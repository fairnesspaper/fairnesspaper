base_model=google/electra-small-discriminator
res_path=/mnt/data/shirin/bias_aware_loss_journal/results/electrasmall.trec
learning_rate=5e-6
max_query_len=32
max_doc_len=256
batch_size=16
n_warmup_steps=1000
task=classification
dataset=/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_pointwise_6M.tsv
regularizer_neg=1
regularizer_pos=1


# penalty pos
#pointwise


# \lambda=2
regularizer_neg=2
regularizer_pos=2
# penalty positive
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pointwise_regression/electrasmall_penalty_pos_1_lambda2.bin
experiment=penalty_pos
echo "penalty positive"
python ../train_regularized_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}

