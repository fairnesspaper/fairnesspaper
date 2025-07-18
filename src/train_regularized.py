import argparse
import time
import sys
import random
import numpy as np
from tqdm import tqdm
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.distributions import Categorical

from transformers import AutoTokenizer, get_linear_schedule_with_warmup
import OpenMatch as om

from OpenMatch.data.datasets.my_dataset_bias import Dataset
from OpenMatch.data.datasets.my_bert_dataset_journal import BertDataset
from OpenMatch.data.datasets.my_roberta_dataset_bias import RobertaDataset
from regularized_loss import bias_regularized_margin_ranking_loss, fairness_regularized_margin_ranking_loss


def dev(args, model, metric, dev_loader, device):
    rst_dict = {}
    for dev_batch in dev_loader:
        query_id, doc_id, label, retrieval_score = dev_batch['query_id'], dev_batch['doc_id'], dev_batch['label'], dev_batch['retrieval_score']
        with torch.no_grad():
            if args.model == 'bert':
                batch_score, _ = model(dev_batch['input_ids'].to(device), dev_batch['input_mask'].to(device), dev_batch['segment_ids'].to(device))
            elif args.model == 'roberta':
                batch_score, _ = model(dev_batch['input_ids'].to(device), dev_batch['input_mask'].to(device))
            elif args.model == 'edrm':
                batch_score, _ = model(dev_batch['query_wrd_idx'].to(device), dev_batch['query_wrd_mask'].to(device),
                                       dev_batch['doc_wrd_idx'].to(device), dev_batch['doc_wrd_mask'].to(device),
                                       dev_batch['query_ent_idx'].to(device), dev_batch['query_ent_mask'].to(device),
                                       dev_batch['doc_ent_idx'].to(device), dev_batch['doc_ent_mask'].to(device),
                                       dev_batch['query_des_idx'].to(device), dev_batch['doc_des_idx'].to(device))
            else:
                batch_score, _ = model(dev_batch['query_idx'].to(device), dev_batch['query_mask'].to(device),
                                       dev_batch['doc_idx'].to(device), dev_batch['doc_mask'].to(device))
            if args.task == 'classification':
                batch_score = batch_score.softmax(dim=-1)[:, 1].squeeze(-1)
            batch_score = batch_score.detach().cpu().tolist()
            for (q_id, d_id, b_s, l) in zip(query_id, doc_id, batch_score, label):
                if q_id not in rst_dict:
                    rst_dict[q_id] = {}
                if d_id not in rst_dict[q_id] or b_s > rst_dict[q_id][d_id][0]:
                    rst_dict[q_id][d_id] = [b_s, l]
    return rst_dict


def train(args, model, loss_fn, m_optim, m_scheduler, metric, train_loader, dev_loader, device):
    best_mes = 0.0
    for epoch in range(args.epoch):
        avg_loss = 0.0
        # data_iter = iter(train_loader)
        # batch = data_iter.__next__()
        for step, train_batch in enumerate(tqdm(train_loader)):
            if args.model == 'bert':
                if args.task == 'ranking':
                    batch_score_pos, _ = model(train_batch['input_ids_pos'].to(device), train_batch['input_mask_pos'].to(device), train_batch['segment_ids_pos'].to(device))
                    batch_score_neg, _ = model(train_batch['input_ids_neg'].to(device), train_batch['input_mask_neg'].to(device), train_batch['segment_ids_neg'].to(device))
                elif args.task == 'classification':
                    batch_score, _ = model(train_batch['input_ids'].to(device), train_batch['input_mask'].to(device), train_batch['segment_ids'].to(device))
                else:
                    raise ValueError('Task must be `ranking` or `classification`.')
            elif args.model == 'roberta':
                if args.task == 'ranking':
                    batch_score_pos, _ = model(train_batch['input_ids_pos'].to(device), train_batch['input_mask_pos'].to(device))
                    batch_score_neg, _ = model(train_batch['input_ids_neg'].to(device), train_batch['input_mask_neg'].to(device))
                elif args.task == 'classification':
                    batch_score, _ = model(train_batch['input_ids'].to(device), train_batch['input_mask'].to(device))
                else:
                    raise ValueError('Task must be `ranking` or `classification`.')
            elif args.model == 'edrm':
                if args.task == 'ranking':
                    batch_score_pos, _ = model(train_batch['query_wrd_idx'].to(device), train_batch['query_wrd_mask'].to(device),
                                               train_batch['doc_pos_wrd_idx'].to(device), train_batch['doc_pos_wrd_mask'].to(device),
                                               train_batch['query_ent_idx'].to(device), train_batch['query_ent_mask'].to(device),
                                               train_batch['doc_pos_ent_idx'].to(device), train_batch['doc_pos_ent_mask'].to(device),
                                               train_batch['query_des_idx'].to(device), train_batch['doc_pos_des_idx'].to(device))
                    batch_score_neg, _ = model(train_batch['query_wrd_idx'].to(device), train_batch['query_wrd_mask'].to(device),
                                               train_batch['doc_neg_wrd_idx'].to(device), train_batch['doc_neg_wrd_mask'].to(device),
                                               train_batch['query_ent_idx'].to(device), train_batch['query_ent_mask'].to(device),
                                               train_batch['doc_neg_ent_idx'].to(device), train_batch['doc_neg_ent_mask'].to(device),
                                               train_batch['query_des_idx'].to(device), train_batch['doc_neg_des_idx'].to(device))
                elif args.task == 'classification':
                    batch_score, _ = model(train_batch['query_wrd_idx'].to(device), train_batch['query_wrd_mask'].to(device),
                                           train_batch['doc_wrd_idx'].to(device), train_batch['doc_wrd_mask'].to(device),
                                           train_batch['query_ent_idx'].to(device), train_batch['query_ent_mask'].to(device),
                                           train_batch['doc_ent_idx'].to(device), train_batch['doc_ent_mask'].to(device),
                                           train_batch['query_des_idx'].to(device), train_batch['doc_des_idx'].to(device))
                else:
                    raise ValueError('Task must be `ranking` or `classification`.')
            else:
                if args.task == 'ranking':
                    batch_score_pos, _ = model(train_batch['query_idx'].to(device), train_batch['query_mask'].to(device),
                                               train_batch['doc_pos_idx'].to(device), train_batch['doc_pos_mask'].to(device))
                    batch_score_neg, _ = model(train_batch['query_idx'].to(device), train_batch['query_mask'].to(device),
                                               train_batch['doc_neg_idx'].to(device), train_batch['doc_neg_mask'].to(device))
                elif args.task == 'classification':
                    batch_score, _ = model(train_batch['query_idx'].to(device), train_batch['query_mask'].to(device),
                                           train_batch['doc_idx'].to(device), train_batch['doc_mask'].to(device))
                else:
                    raise ValueError('Task must be `ranking` or `classification`.')
            if args.task == 'ranking':
                # batch_loss = loss_fn(batch_score_pos.tanh(), batch_score_neg.tanh(), torch.ones(batch_score_pos.size()).to(device))
                if args.experiment == 'penalty_neg':
                    batch_loss = bias_regularized_margin_ranking_loss(batch_score_pos.tanh(), batch_score_neg.tanh(),
                                                                  regularizer_neg=args.regularizer_neg,
                                                                  bias_neg=train_batch["bias_neg"].to(device))
                elif args.experiment == 'penalty_pos':
                    batch_loss = bias_regularized_margin_ranking_loss(batch_score_pos.tanh(), batch_score_neg.tanh(),
                                                                  regularizer_pos=args.regularizer_pos,
                                                                  bias_pos=train_batch["bias_pos"].to(device))
                elif args.experiment == 'penalty_both':
                    batch_loss = bias_regularized_margin_ranking_loss(batch_score_pos.tanh(), batch_score_neg.tanh(),
                                                                  regularizer_neg=args.regularizer_neg, regularizer_pos=args.regularizer_pos,
                                                                  bias_neg=train_batch["bias_neg"].to(device), 
                                                                  bias_pos=train_batch["bias_pos"].to(device))
                elif args.experiment == 'reward_neg':
                    batch_loss = fairness_regularized_margin_ranking_loss(batch_score_pos.tanh(), batch_score_neg.tanh(),
                                                                  regularizer_neg=args.regularizer_neg,
                                                                  fairness_neg=train_batch["fairness_neg"].to(device))
                elif args.experiment == 'reward_pos':
                    batch_loss = fairness_regularized_margin_ranking_loss(batch_score_pos.tanh(), batch_score_neg.tanh(),
                                                                  regularizer_pos=args.regularizer_pos,
                                                                  fairness_pos=train_batch["fairness_pos"].to(device))
                elif args.experiment == 'reward_both':
                    batch_loss = fairness_regularized_margin_ranking_loss(batch_score_pos.tanh(), batch_score_neg.tanh(),
                                                                  regularizer_pos=args.regularizer_pos, regularizer_neg=args.regularizer_neg, 
                                                                  fairness_neg=train_batch["fairness_neg"].to(device),
                                                                  fairness_pos=train_batch["fairness_pos"].to(device))
                else:
                    print("experiment is not supported")
                    break

            elif args.task == 'classification':
                # batch_loss = loss_fn(batch_score, train_batch['label'].to(device))
                
                #print(train_batch['label'])
                if args.experiment == 'penalty_neg' or args.experiment == 'penalty_both':
                    # regularizer_term = args.regularizer_neg * (train_batch['label'].to(device) - 1) * train_batch['bias'].to(device)
                    # regularizer_term = regularizer_term.unsqueeze(-1)  # Shape (batch_size, 1)
                    # addition_tensor = torch.cat((regularizer_term, torch.zeros_like(regularizer_term)), dim=-1)  # Shape (batch_size, 2)
                    # batch_score = batch_score + addition_tensor
                    regularizer_term_neg = args.regularizer_neg * (train_batch['label'].to(device) - 1) * train_batch['bias'].to(device)
                    regularizer_term_neg = regularizer_term_neg.unsqueeze(-1)  # Shape (batch_size, 1)
                    regularizer_term_pos = args.regularizer_neg * (1- train_batch['label'].to(device)) * train_batch['bias'].to(device)
                    regularizer_term_pos = regularizer_term_pos.unsqueeze(-1)  # Shape (batch_size, 1)

                    addition_tensor = torch.cat((regularizer_term_neg, regularizer_term_pos), dim=-1)  # Shape (batch_size, 2)
                    batch_score = batch_score + addition_tensor
                elif args.experiment == 'reward_neg' or args.experiment == 'reward_both':
                    # regularizer_term = args.regularizer_neg * (-train_batch['label'].to(device) + 1) * train_batch['fairness'].to(device)
                    # regularizer_term = regularizer_term.unsqueeze(-1)  # Shape (batch_size, 1)
                    # addition_tensor = torch.cat((regularizer_term, torch.zeros_like(regularizer_term)), dim=-1)  # Shape (batch_size, 2)
                    # batch_score = batch_score + addition_tensor
                    regularizer_term_neg = args.regularizer_neg * (-train_batch['label'].to(device) + 1) * train_batch['fairness'].to(device)
                    regularizer_term_neg = regularizer_term_neg.unsqueeze(-1)  # Shape (batch_size, 1)
                    regularizer_term_pos = args.regularizer_neg * (train_batch['label'].to(device)-1) * train_batch['bias'].to(device)
                    regularizer_term_pos = regularizer_term_pos.unsqueeze(-1)  # Shape (batch_size, 1)

                    addition_tensor = torch.cat((regularizer_term_neg, regularizer_term_pos), dim=-1)  # Shape (batch_size, 2)
                    batch_score = batch_score + addition_tensor
                if args.experiment == 'penalty_pos' or args.experiment == 'penalty_both':
                    # regularizer_term = args.regularizer_pos * (train_batch['label'].to(device)) * train_batch['bias'].to(device)
                    # regularizer_term = regularizer_term.unsqueeze(-1)  # Shape (batch_size, 1)
                    # addition_tensor = torch.cat((torch.zeros_like(regularizer_term), regularizer_term), dim=-1)  # Shape (batch_size, 2)
                    # batch_score = batch_score + addition_tensor
                    regularizer_term_neg = args.regularizer_neg * (-train_batch['label'].to(device)) * train_batch['fairness'].to(device)
                    regularizer_term_neg = regularizer_term_neg.unsqueeze(-1)  # Shape (batch_size, 1)
                    regularizer_term_pos = args.regularizer_pos * (train_batch['label'].to(device)) * train_batch['bias'].to(device)
                    regularizer_term_pos = regularizer_term_pos.unsqueeze(-1)  # Shape (batch_size, 1)

                    addition_tensor = torch.cat((regularizer_term_neg, regularizer_term_pos), dim=-1)  # Shape (batch_size, 2)
                    batch_score = batch_score + addition_tensor
                elif args.experiment == 'reward_pos' or args.experiment == 'reward_both':
                    # regularizer_term = args.regularizer_pos * (-train_batch['label'].to(device)) * train_batch['fairness'].to(device)
                    # regularizer_term = regularizer_term.unsqueeze(-1)  # Shape (batch_size, 1)
                    # addition_tensor = torch.cat((torch.zeros_like(regularizer_term), regularizer_term), dim=-1)  # Shape (batch_size, 2)
                    # batch_score = batch_score + addition_tensor 
                    regularizer_term_neg = args.regularizer_neg * (train_batch['label'].to(device)) * train_batch['fairness'].to(device)
                    regularizer_term_neg = regularizer_term_neg.unsqueeze(-1)  # Shape (batch_size, 1)
                    regularizer_term_pos = args.regularizer_pos * (-train_batch['label'].to(device)) * train_batch['fairness'].to(device)
                    regularizer_term_pos = regularizer_term_pos.unsqueeze(-1)  # Shape (batch_size, 1)

                    addition_tensor = torch.cat((regularizer_term_neg, regularizer_term_pos), dim=-1)  # Shape (batch_size, 2)
                    batch_score = batch_score + addition_tensor
                    

                batch_loss = loss_fn(batch_score, train_batch['label'].to(device))
            else:
                raise ValueError('Task must be `ranking` or `classification`.')
            if torch.cuda.device_count() > 1:
                batch_loss = batch_loss.mean()
            avg_loss += batch_loss.item()
            batch_loss.backward()
            m_optim.step()
            m_scheduler.step()
            m_optim.zero_grad()

            if (step+1) % args.eval_every == 0:
                with torch.no_grad():
                    rst_dict = dev(args, model, metric, dev_loader, device)
                    om.utils.save_trec(args.res, rst_dict)
                    if args.metric.split('_')[0] == 'mrr':
                        mes = metric.get_mrr(args.qrels, args.res, args.metric)
                    else:
                        mes = metric.get_metric(args.qrels, args.res, args.metric)
                if mes >= best_mes:
                    best_mes = mes
                    print('save_model...')
                    if torch.cuda.device_count() > 1:
                        torch.save(model.module.state_dict(), args.save)
                    else:
                        torch.save(model.state_dict(), args.save)
                print(step+1, avg_loss/args.eval_every, mes, best_mes)
                avg_loss = 0.0


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-task', type=str, default='ranking')
    parser.add_argument('-model', type=str, default='bert')
    parser.add_argument('-reinfoselect', action='store_true', default=False)
    parser.add_argument('-reset', action='store_true', default=False)
    parser.add_argument('-train', action=om.utils.DictOrStr, default='/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_6M.tsv')
    parser.add_argument('-max_input', type=int, default=3000000)
    parser.add_argument('-save', type=str, default='./checkpoints/bert.bin')
    parser.add_argument('-dev', action=om.utils.DictOrStr, default='/mnt/data/shirin/bias_aware_loss_journal/data/dev.100.jsonl')
    parser.add_argument('-qrels', type=str, default='/mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv')
    parser.add_argument('-vocab', type=str, default='allenai/scibert_scivocab_uncased/vocab.txt')
    parser.add_argument('-ent_vocab', type=str, default='')
    parser.add_argument('-pretrain', type=str, default='allenai/scibert_scivocab_uncased')
    parser.add_argument('-checkpoint', type=str, default=None)
    parser.add_argument('-res', type=str, default='./results/bert.trec')
    parser.add_argument('-metric', type=str, default='mrr_cut_10')
    parser.add_argument('-mode', type=str, default='cls')
    parser.add_argument('-n_kernels', type=int, default=21)
    parser.add_argument('-max_query_len', type=int, default=32)
    parser.add_argument('-max_doc_len', type=int, default=221)
    parser.add_argument('-maxp', action='store_true', default=False)
    parser.add_argument('-epoch', type=int, default=1)
    parser.add_argument('-batch_size', type=int, default=8)
    parser.add_argument('-lr', type=float, default=2e-5)
    parser.add_argument('-tau', type=float, default=1)
    parser.add_argument('-n_warmup_steps', type=int, default=1000)
    parser.add_argument('-eval_every', type=int, default=10000)
    parser.add_argument('-regularizer_neg', type=float, default=1)
    parser.add_argument('-regularizer_pos', type=float, default=1)
    parser.add_argument('-experiment', type=str, required=True)
    # sys.argv = ["train_regularized.py", "-vocab", "sentence-transformers/msmarco-MiniLM-L6-cos-v5",
    # "-pretrain", "sentence-transformers/msmarco-MiniLM-L6-cos-v5", "-res", "/home/ir-bias/Shirin/bias_aware_loss_journal/results/minilm.trec", 
    # "-save", "/home/ir-bias/Shirin/bias_aware_loss_journal/checkpoints/minilm/pairwise/minilm_penalty_neg.bin", "-n_warmup_steps", "160000", 
    # "-batch_size", "16", "-lr", "3e-6", "-experiment", "penalty_neg"]
    args = parser.parse_args()
    # set the seed value
    # seed_value = 42
    # random.seed(seed_value)
    # np.random.seed(seed_value)
    # torch.manual_seed(seed_value)
    # if torch.cuda.is_available():
        # torch.cuda.manual_seed_all(seed_value)

    args.model = args.model.lower()
    if args.model == 'bert':
        tokenizer = AutoTokenizer.from_pretrained(args.vocab)
        print('reading training data...')
        if args.maxp:
            train_set = om.data.datasets.BertMaxPDataset(
                dataset=args.train,
                tokenizer=tokenizer,
                mode='train',
                query_max_len=args.max_query_len,
                doc_max_len=args.max_doc_len,
                max_input=args.max_input,
                task=args.task
            )
        else:
            train_set = BertDataset(
                dataset=args.train,
                tokenizer=tokenizer,
                mode='train',
                query_max_len=args.max_query_len,
                doc_max_len=args.max_doc_len,
                max_input=args.max_input,
                task=args.task
            )
        print('reading dev data...')
        if args.maxp:
            dev_set = om.data.datasets.BertMaxPDataset(
                dataset=args.dev,
                tokenizer=tokenizer,
                mode='dev',
                query_max_len=args.max_query_len,
                doc_max_len=args.max_doc_len,
                max_input=args.max_input,
                task=args.task
            )
        else:
            dev_set = om.data.datasets.BertDataset(
                dataset=args.dev,
                tokenizer=tokenizer,
                mode='dev',
                query_max_len=args.max_query_len,
                doc_max_len=args.max_doc_len,
                max_input=args.max_input,
               task=args.task
            )
    elif args.model == 'roberta':
        tokenizer = AutoTokenizer.from_pretrained(args.vocab)
        print('reading training data...')
        train_set = RobertaDataset(
            dataset=args.train,
            tokenizer=tokenizer,
            mode='train',
            query_max_len=args.max_query_len,
            doc_max_len=args.max_doc_len,
            max_input=args.max_input,
            task=args.task
        )
        print('reading dev data...')
        dev_set = om.data.datasets.RobertaDataset(
            dataset=args.dev,
            tokenizer=tokenizer,
            mode='dev',
            query_max_len=args.max_query_len,
            doc_max_len=args.max_doc_len,
            max_input=args.max_input,
            task=args.task
        )
    elif args.model == 'edrm':
        tokenizer = om.data.tokenizers.WordTokenizer(
            pretrained=args.vocab
        )
        ent_tokenizer = om.data.tokenizers.WordTokenizer(
            vocab=args.ent_vocab
        )
        print('reading training data...')
        train_set = om.data.datasets.EDRMDataset(
            dataset=args.train,
            wrd_tokenizer=tokenizer,
            ent_tokenizer=ent_tokenizer,
            mode='train',
            query_max_len=args.max_query_len,
            doc_max_len=args.max_doc_len,
            des_max_len=20,
            max_ent_num=3,
            max_input=args.max_input,
            task=args.task
        )
        print('reading dev data...')
        dev_set = om.data.datasets.EDRMDataset(
            dataset=args.dev,
            wrd_tokenizer=tokenizer,
            ent_tokenizer=ent_tokenizer,
            mode='dev',
            query_max_len=args.max_query_len,
            doc_max_len=args.max_doc_len,
            des_max_len=20,
            max_ent_num=3,
            max_input=args.max_input,
            task=args.task
        )
    else:
        tokenizer = om.data.tokenizers.WordTokenizer(
            pretrained=args.vocab
        )
        print('reading training data...')
        train_set = Dataset(
            dataset=args.train,
            tokenizer=tokenizer,
            mode='train',
            query_max_len=args.max_query_len,
            doc_max_len=args.max_doc_len,
            max_input=args.max_input,
            task=args.task
        )
        print('reading dev data...')
        dev_set = om.data.datasets.Dataset(
            dataset=args.dev,
            tokenizer=tokenizer,
            mode='dev',
            query_max_len=args.max_query_len,
            doc_max_len=args.max_doc_len,
            max_input=args.max_input,
            task=args.task
        )
    train_loader = om.data.DataLoader(
        dataset=train_set,
        batch_size=args.batch_size,
        shuffle=True,
        num_workers=1
    )
    dev_loader = om.data.DataLoader(
        dataset=dev_set,
        batch_size=args.batch_size * 16,
        shuffle=False,
        num_workers=1
    )

    if args.model == 'bert' or args.model == 'roberta':
        if args.maxp:
            model = om.models.BertMaxP(
                pretrained=args.pretrain,
                max_query_len=args.max_query_len,
                max_doc_len=args.max_doc_len,
                mode=args.mode,
                task=args.task
            )
        else:
            model = om.models.Bert(
                pretrained=args.pretrain,
                mode=args.mode,
                task=args.task
            )
        if args.reinfoselect:
            policy = om.models.Bert(
                pretrained=args.pretrain,
                mode=args.mode,
                task='classification'
            )
    elif args.model == 'edrm':
        model = om.models.EDRM(
            wrd_vocab_size=tokenizer.get_vocab_size(),
            ent_vocab_size=ent_tokenizer.get_vocab_size(),
            wrd_embed_dim=tokenizer.get_embed_dim(),
            ent_embed_dim=128,
            max_des_len=20,
            max_ent_num=3,
            kernel_num=args.n_kernels,
            kernel_dim=128,
            kernel_sizes=[1, 2, 3],
            wrd_embed_matrix=tokenizer.get_embed_matrix(),
            ent_embed_matrix=None,
            task=args.task
        )
    elif args.model == 'tk':
        model = om.models.TK(
            vocab_size=tokenizer.get_vocab_size(),
            embed_dim=tokenizer.get_embed_dim(),
            head_num=10,
            hidden_dim=100,
            layer_num=2,
            kernel_num=args.n_kernels,
            dropout=0.0,
            embed_matrix=tokenizer.get_embed_matrix(),
            task=args.task
        )
    elif args.model == 'cknrm':
        model = om.models.ConvKNRM(
            vocab_size=tokenizer.get_vocab_size(),
            embed_dim=tokenizer.get_embed_dim(),
            kernel_num=args.n_kernels,
            kernel_dim=128,
            kernel_sizes=[1, 2, 3],
            embed_matrix=tokenizer.get_embed_matrix(),
            task=args.task
        )
    elif args.model == 'knrm':
        model = om.models.KNRM(
            vocab_size=tokenizer.get_vocab_size(),
            embed_dim=tokenizer.get_embed_dim(),
            kernel_num=args.n_kernels,
            embed_matrix=tokenizer.get_embed_matrix(),
            task=args.task
        )
    else:
        raise ValueError('model name error.')

    if args.reinfoselect and args.model != 'bert':
        policy = om.models.ConvKNRM(
            vocab_size=tokenizer.get_vocab_size(),
            embed_dim=tokenizer.get_embed_dim(),
            kernel_num=args.n_kernels,
            kernel_dim=128,
            kernel_sizes=[1, 2, 3],
            embed_matrix=tokenizer.get_embed_matrix(),
            task='classification'
        )

    if args.checkpoint is not None:
        state_dict = torch.load(args.checkpoint)
        if args.model == 'bert':
            st = {}
            for k in state_dict:
                if k.startswith('bert'):
                    st['_model'+k[len('bert'):]] = state_dict[k]
                elif k.startswith('classifier'):
                    st['_dense'+k[len('classifier'):]] = state_dict[k]
                else:
                    st[k] = state_dict[k]
            model.load_state_dict(st)
        else:
            model.load_state_dict(state_dict)

    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    if args.reinfoselect:
        if args.task == 'ranking':
            loss_fn = nn.MarginRankingLoss(margin=1, reduction='none')
        elif args.task == 'classification':
            loss_fn = nn.CrossEntropyLoss(reduction='none')
        else:
            raise ValueError('Task must be `ranking` or `classification`.')
    else:
        if args.task == 'ranking':
            loss_fn = nn.MarginRankingLoss(margin=1)
        elif args.task == 'classification':
            loss_fn = nn.CrossEntropyLoss()
        else:
            raise ValueError('Task must be `ranking` or `classification`.')
    m_optim = torch.optim.Adam(filter(lambda p: p.requires_grad, model.parameters()), lr=args.lr)
    m_scheduler = get_linear_schedule_with_warmup(m_optim, num_warmup_steps=args.n_warmup_steps, num_training_steps=len(train_set)*args.epoch//args.batch_size)
    if args.reinfoselect:
        p_optim = torch.optim.Adam(filter(lambda p: p.requires_grad, policy.parameters()), lr=args.lr)
    metric = om.metrics.Metric()

    model.to(device)
    if args.reinfoselect:
        policy.to(device)
    loss_fn.to(device)
    if torch.cuda.device_count() > 1:
        model = nn.DataParallel(model)
        loss_fn = nn.DataParallel(loss_fn)

    if args.reinfoselect:
        print('reinforce not supported for the bias-aware version')
    else:
        time1 = time.time()
        print("start training")
        train(args, model, loss_fn, m_optim, m_scheduler, metric, train_loader, dev_loader, device)
        time2 = time.time()
        print("training time = {}".format(time2-time1))


if __name__ == "__main__":
    main()
