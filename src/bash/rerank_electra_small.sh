base_model=google/electra-small-discriminator
max_query_len=32
max_doc_len=256
batch_size=512
docs=/mnt/data/shirin/msmarco/collection.tsv

task=classification

 
# checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pointwise_regression/electrasmall_original_${experiment_number}.bin
# # # 215 queries
# # queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv
# # # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# # trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec
# # # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/select_one/electrasmall_original_${experiment_number}.trec
# # # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_original_${experiment_number}.trec
# # python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# # original 1765
# queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/female_queries.tsv
# trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.female_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/electrasmall/pointwise/regression/electrasmall_original_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_female_queries/electrasmall/pairwise/electrasmall_original_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pointwise_regression/electrasmall_penalty_neg_${experiment_number}.bin
# # # penalty neg 215
# queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_neg_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# # penalty neg 1765
# queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/electrasmall/pointwise/regression/electrasmall_penalty_neg_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pointwise_regression/electrasmall_penalty_pos_${experiment_number}.bin
# penalty pos 215
queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv
# queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec
# trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_${experiment_number}.trec
python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# penalty pos 1765
# queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pointwise_regression/electrasmall_penalty_both_${experiment_number}.bin
# # penalty both 215
# queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_both_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# # penalty both 1765
# queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/electrasmall/pointwise/regression/electrasmall_penalty_both_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pointwise_regression/electrasmall_fairness_neg_${experiment_number}.bin
# # # reward neg 215
# # queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv
# # # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# # trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec
# # # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_fairness_neg_${experiment_number}.trec
# # # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# # python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# # reward neg 1765
# queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/electrasmall/pointwise/regression/electrasmall_fairness_neg_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pointwise_regression/electrasmall_fairness_pos_${experiment_number}.bin
# # # reward pos 215
# # queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv
# # # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# # trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec
# # # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_fairness_pos_${experiment_number}.trec
# # # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# # python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# # reward pos 1765
# queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/electrasmall/pointwise/regression/electrasmall_fairness_pos_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# checkpoint=/mnt/data/shirin/bias_aware_loss_journal/checkpoints/electrasmall/pointwise_regression/electrasmall_fairness_both_${experiment_number}.bin
# # reward both 215
# queries=/mnt/data/shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_fairness_both_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

# reward both 1765
# queries=/mnt/data/shirin/target_queries/navid_neutrals/neutral_queries.tsv
# # queries=/mnt/data/shirin/target_queries/ecir_neutrals/male_queries.tsv
# trec=/mnt/data/shirin/target_queries/navid_neutrals/run.neutral_queries.trec
# # trec=/mnt/data/shirin/target_queries/ecir_neutrals/run.male_queries_ecir.trec
# res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/electrasmall/pointwise/regression/electrasmall_fairness_both_${experiment_number}.trec
# # res_path=/mnt/data/shirin/bias_aware_loss_journal/reranked/1405_male_queries/electrasmall/pairwise/electrasmall_penalty_neg_${experiment_number}.trec
# python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}
