base_model=prajjwal1/bert-tiny
max_query_len=32
max_doc_len=221
batch_size=1024
task=ranking
 
# original 215
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/berttiny/pairwise/berttiny_original_${experiment_number}.trec
checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_original_${experiment_number}.bin

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# original 1765
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/berttiny/pairwise/berttiny_original_${experiment_number}.trec

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# penalty neg 215
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/berttiny/pairwise/berttiny_penalty_neg_${experiment_number}.trec
checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_penalty_neg_${experiment_number}.bin

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# penalty neg 1765
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/berttiny/pairwise/berttiny_penalty_neg_${experiment_number}.trec

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# penalty pos 215
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/berttiny/pairwise/berttiny_penalty_pos_${experiment_number}.trec
checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_penalty_pos_${experiment_number}.bin

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# penalty pos 1765
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/berttiny/pairwise/berttiny_penalty_pos_${experiment_number}.trec

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# penalty both 215
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/berttiny/pairwise/berttiny_penalty_both_${experiment_number}.trec
checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_penalty_both_${experiment_number}.bin

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# penalty both 1765
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/berttiny/pairwise/berttiny_penalty_both_${experiment_number}.trec

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# reward neg 215
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/berttiny/pairwise/berttiny_fairness_neg_${experiment_number}.trec
checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_fairness_neg_${experiment_number}.bin

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# reward neg 1765
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/berttiny/pairwise/berttiny_fairness_neg_${experiment_number}.trec

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# reward pos 215
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/berttiny/pairwise/berttiny_fairness_pos_${experiment_number}.trec
checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_fairness_pos_${experiment_number}.bin

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# reward pos 1765
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/berttiny/pairwise/berttiny_fairness_pos_${experiment_number}.trec

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# reward both 215
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/berttiny/pairwise/berttiny_fairness_both_${experiment_number}.trec
checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/berttiny/pairwise/berttiny_fairness_both_${experiment_number}.bin

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# reward both 1765
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/berttiny/pairwise/berttiny_fairness_both_${experiment_number}.trec

python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/mnt/data/shirin/msmarco/collection.tsv,trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec

