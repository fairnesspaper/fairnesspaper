################################### Pointwise ###################################
base_model=bert-base-uncased
res_path=../results/bertbase.trec
learning_rate=3e-6
max_query_len=32
max_doc_len=221
batch_size=16
n_warmup_steps=160000
task=classification
dataset=../data/dataset_journal_pointwise.tsv

# original
save_path=../checkpoints/bertbase/pointwise/bertbase_original.bin
echo "original"
python my_train_original.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# penalty negative
save_path=../checkpoints/bertbase/pointwise/bertbase_penalty_neg.bin
experiment=penalty_neg
echo "penalty negative"
python train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# penalty positive
save_path=../checkpoints/bertbase/pointwise/bertbase_penalty_pos.bin
experiment=penalty_pos
echo "penalty positive"
python train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# penalty both
save_path=../checkpoints/bertbase/pointwise/bertbase_penalty_both.bin
experiment=penalty_both
echo "penalty both"
python train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# fairness neg
save_path=../checkpoints/bertbase/pointwise/bertbase_fairness_neg.bin
experiment=reward_neg
echo "fairness neg"
python train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# fairness pos
save_path=../checkpoints/bertbase/pointwise/bertbase_fairness_pos.bin
experiment=reward_pos
echo "fairness pos"
python train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}


# fairness both
save_path=../checkpoints/bertbase/pointwise/bertbase_fairness_both.bin
experiment=reward_both
echo "fairness both"
python train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}
