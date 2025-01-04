base_model=prajjwal1/bert-tiny
res_path=/mnt/data/shirin/bias_aware_loss_journal/results/berttiny.trec
learning_rate=3e-6
max_query_len=32
max_doc_len=221
batch_size=16
n_warmup_steps=160000
dataset=/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_6M.tsv

# original
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_original_4.bin
echo "original"
python ../my_train_original.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -train ${dataset}

# penalty negative
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_penalty_neg_4.bin
experiment=penalty_neg
echo "penalty negative"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}

# penalty positive
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_penalty_pos_4.bin
experiment=penalty_pos
echo "penalty positive"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}

# penalty both
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_penalty_both_4.bin
experiment=penalty_both
echo "penalty both"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}

# fairness neg
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_fairness_neg_4.bin
experiment=reward_neg
echo "fairness neg"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}

# fairness pos
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_fairness_pos_4.bin
experiment=reward_pos
echo "fairness pos"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}


# fairness both
save_path=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_fairness_both_4.bin
experiment=reward_both
echo "fairness both"
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}
