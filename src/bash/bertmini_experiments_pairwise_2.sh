base_model=prajjwal1/bert-mini
res_path=/mnt/data/shirin/bias_aware_loss_journal/results/bertmini.trec
learning_rate=3e-6
max_query_len=32
max_doc_len=221
batch_size=16
n_warmup_steps=160000
dataset=/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_6M.tsv

# # original
# save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pairwise/bertmini_original_2.bin
# echo "original"
# python ../my_train_original.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -train ${dataset}

# # penalty negative
# save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pairwise/bertmini_penalty_neg_2.bin
# experiment=penalty_neg
# echo "penalty negative"
# python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}

# penalty positive
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pairwise/bertmini_penalty_pos_2.bin
experiment=penalty_pos
echo "penalty positive"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}

# penalty both
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pairwise/bertmini_penalty_both_2.bin
experiment=penalty_both
echo "penalty both"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}

# # fairness neg
# save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pairwise/bertmini_fairness_neg_2.bin
# experiment=reward_neg
# echo "fairness neg"
# python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}

# fairness pos
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pairwise/bertmini_fairness_pos_2.bin
experiment=reward_pos
echo "fairness pos"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}


# fairness both
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/bertmini/pairwise/bertmini_fairness_both_2.bin
experiment=reward_both
echo "fairness both"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}
