from calculate_doc_bias import DocBias
import csv
import pandas as pd


def create_train_data_bias(msmarco_triple_path, bias_dataset_savepath, bias_meter):
    with open(msmarco_triple_path, 'r') as msmarco_dataset,\
         open(bias_dataset_savepath, 'w') as my_dataset:
        dataset_bias = []
        writer = csv.writer(my_dataset, delimiter='\t')
        for n, line in enumerate(msmarco_dataset):
            print("sample {}".format(n))
            query, doc_pos, doc_neg = line.strip('\n').split('\t')
            bias_negative = bias_meter.get_bias(bias_meter.get_tokens(doc_neg))
            dataset_bias.append([query, doc_pos, doc_neg, abs(bias_negative[0])])
        writer.writerows(dataset_bias)


def create_train_data_bias_2(msmarco_triple_path, bias_dataset_savepath, bias_meter):
    with open(msmarco_triple_path, 'r') as msmarco_dataset,\
         open(bias_dataset_savepath, 'w') as my_dataset:
        dataset_bias = []
        writer = csv.writer(my_dataset, delimiter='\t')
        for n, line in enumerate(msmarco_dataset):
            print("sample {}".format(n))
            query, doc_pos, doc_neg = line.strip('\n').split('\t')
            bias_negative = bias_meter.get_bias(bias_meter.get_tokens(doc_neg))
            bias_positive = bias_meter.get_bias(bias_meter.get_tokens(doc_pos))
            dataset_bias.append([query, doc_pos, doc_neg, abs(bias_negative[0]), abs(bias_positive[0])])
        writer.writerows(dataset_bias)

#
# def create_train_data_refinement(msmarco_triple_id_path, msmarco_collection_path,
#                                  msmarco_queries_path,
#                                  refinement_dataset_savepath, query_pair_path):
#     print("loading data...")
#     collection = pd.read_csv(msmarco_collection_path, sep='\t', names=["pid", "passage"])
#     queries = pd.read_csv(msmarco_queries_path, sep='\t', names=["qid", "query"])
#     query_pairs = pd.read_csv(query_pair_path, sep='\t', names=["qid", "q_initial", "map_initial",
#                                                                 "q_destination", "map_destination"])
#     with open(msmarco_triple_id_path, 'r') as msmarco_dataset, \
#         open(refinement_dataset_savepath, 'w') as my_dataset:
#         writer = csv.writer(my_dataset, delimiter='\t')
#         n_total = 0
#         n_my_samples = 0
#         max_samples = 2000000
#         for line in msmarco_dataset:
#             n_total += 1
#             if n_total > max_samples:
#                 print('max samples is satisfied')
#                 break
#             print("{}th sample of the main dataset".format(n_total))
#             query_id, pos_id, neg_id = line.strip('\n').split('\t')
#             query_id = int(query_id)
#             pos_id = int(pos_id)
#             neg_id = int(neg_id)
#             if query_id in query_pairs["qid"].tolist():
#                 n_my_samples += 1
#                 print("my sample {}".format(n_my_samples))
#                 selected_row = query_pairs[query_pairs["qid"] == query_id]
#                 query_destination = selected_row["q_destination"].tolist()
#
#                 selected_row = queries[queries["qid"] == query_id]
#                 query = selected_row["query"].tolist()
#
#                 selected_row = collection[collection["pid"] == pos_id]
#                 doc_pos = selected_row["passage"].tolist()
#
#                 selected_row= collection[collection["pid"] == neg_id]
#                 doc_neg = selected_row["passage"].tolist()
#                 new_row = [query[0], doc_pos[0], doc_neg[0], query_destination[0]]
#                 writer.writerow(new_row)
#         print("dataset size = {}".format(n_my_samples))


if __name__ == "__main__":
    gendered_vocab_path = "./data/wordlist_genderspecific.txt"
    bias_meter = DocBias(gendered_vocab_path)
    #
    msmarco_triple_path = "./data/triples.train.small.tsv"
    bias_dataset_savepath = "./data/bias_dataset_2.tsv"
    create_train_data_bias_2(msmarco_triple_path, bias_dataset_savepath, bias_meter)
    # msmarco_triple_id_path = "./data/qidpidtriples.train.full.2.tsv"
    # msmarco_collection_path = "./data/collection.tsv"
    # msmarco_queries_path = "./data/queries.train.tsv"
    # # refinement_dataset_savepath = "./data/refinement_diamond_dataset.tsv"
    # query_pair_path = "./data/diamond_dataset.tsv"
    # create_train_data_refinement(msmarco_triple_id_path, msmarco_collection_path,
    #                              msmarco_queries_path,
    #                              refinement_dataset_savepath, query_pair_path)
