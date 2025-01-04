base_model=google/electra-small-discriminator
res_path=/mnt/data/shirin/bias_aware_loss_journal/results/electrasmall.trec
learning_rate=5e-6
max_query_len=32
max_doc_len=256
batch_size=16
n_warmup_steps=1000



# penalty positive
regularizer_neg=0.1
regularizer_pos=0.1
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_penalty_pos_4_lambda0.1.bin
experiment=penalty_pos
echo "lambda 0.1"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}



# penalty positive
regularizer_neg=0.5
regularizer_pos=0.5
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_penalty_pos_4_lambda0.5.bin
experiment=penalty_pos
echo "plambda 0.5"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}



# penalty positive
regularizer_neg=2
regularizer_pos=2
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_penalty_pos_4_lambda2.bin
experiment=penalty_pos
echo "lambda 2"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}



# penalty positive
regularizer_neg=5
regularizer_pos=5
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_penalty_pos_4_lambda5.bin
experiment=penalty_pos
echo "lambda 5"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}
