base_model=google/electra-small-discriminator
res_path=/mnt/data/shirin/bias_aware_loss_journal/results/electrasmall.trec
learning_rate=5e-6
max_query_len=32
max_doc_len=256
batch_size=16
n_warmup_steps=1000

# original
#save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_original_3.bin
#echo "original"
#python ../my_train_original.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# # penalty negative
# save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/pairwise/electrasmall_penalty_neg_3.bin
# experiment=penalty_neg
# echo "penalty negative"
# python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# penalty positive
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_penalty_pos_3.bin
experiment=penalty_pos
echo "penalty positive"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# penalty both
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_penalty_both_3.bin
experiment=penalty_both
echo "penalty both"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# # fairness neg
# save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_fairness_neg_3.bin
# experiment=reward_neg
# echo "fairness neg"
# python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}

# fairness pos
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_fairness_pos_3.bin
experiment=reward_pos
echo "fairness pos"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}


# fairness both
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pairwise/electrasmall_fairness_both_3.bin
experiment=reward_both
echo "fairness both"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len}
