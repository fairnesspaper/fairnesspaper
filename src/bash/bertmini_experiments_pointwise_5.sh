base_model=prajjwal1/bert-mini
res_path=/mnt/data/shirin/bias_aware_loss_journal/results/bertmini_5.trec
learning_rate=3e-6
max_query_len=32
max_doc_len=221
batch_size=16
n_warmup_steps=160000
dataset=/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_pointwise_6M.tsv
task=classification
dataset=/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_pointwise_6M.tsv
regularizer_neg=1
regularizer_pos=1

# original
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pointwise_regression/bertmini_original_5.bin
echo "original"
python ../my_train_original_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset}

# penalty negative
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pointwise_regression/bertmini_penalty_neg_5.bin
experiment=penalty_neg
echo "penalty negative"
python ../train_regularized_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}

# penalty positive
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pointwise_regression/bertmini_penalty_pos_5.bin
experiment=penalty_pos
echo "penalty positive"
python ../train_regularized_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}

# penalty both
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pointwise_regression/bertmini_penalty_both_5.bin
experiment=penalty_both
echo "penalty negative"
python ../train_regularized_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}

# fairness neg
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pointwise_regression/bertmini_fairness_neg_5.bin
experiment=reward_neg
echo "fairness neg"
python ../train_regularized_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}


# fairness pos
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pointwise_regression/bertmini_fairness_pos_5.bin
experiment=reward_pos
echo "fairness pos"
python ../train_regularized_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}


# fairness both
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pointwise_regression/bertmini_fairness_both_5.bin
experiment=reward_both
echo "fairness both"
python ../train_regularized_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}
