base_model=sentence-transformers/msmarco-MiniLM-L6-cos-v5
max_query_len=32
max_doc_len=221
batch_size=256
task=ranking
 
# original 215
res_path=../reranked/215_queries/minilm/pairwise/minilm_original.trec
checkpoint=../checkpoints/minilm/pairwise/minilm_original.bin
# res_path=../reranked/215_queries/minilm/pointwise/minilm_original.trec
# checkpoint=../checkpoints/minilm/pointwise/minilm_original.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec -task ${task}

# # original 1765
# res_path=../reranked/1765_queries/minilm/pairwise/minilm_original.trec
# # res_path=../reranked/1765_queries/minilm/pointwise/minilm_original.trec

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec -task ${task}

# penalty neg 215
res_path=../reranked/215_queries/minilm/pairwise/minilm_penalty_neg.trec
checkpoint=../checkpoints/minilm/pairwise/minilm_penalty_neg.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec -task ${task}

# penalty neg 1765
# res_path=../reranked/1765_queries/minilm/pairwise/minilm_penalty_neg.trec

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec -task ${task}

# # penalty pos 215
# res_path=../reranked/215_queries/minilm/minilm_penalty_pos.trec
# checkpoint=../checkpoints/minilm/minilm_penalty_pos.bin

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec -task ${task}

# # penalty pos 1765
# res_path=../reranked/1765_queries/minilm/minilm_penalty_pos.trec

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec -task ${task}

# # penalty both 215
# res_path=../reranked/215_queries/minilm/minilm_penalty_both.trec
# checkpoint=../checkpoints/minilm/minilm_penalty_both.bin

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec -task ${task}

# # penalty both 1765
# res_path=../reranked/1765_queries/minilm/minilm_penalty_both.trec

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec -task ${task}

# # reward neg 215
# res_path=../reranked/215_queries/minilm/minilm_fairness_neg.trec
# checkpoint=../checkpoints/minilm/minilm_fairness_neg.bin

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec -task ${task}

# # reward neg 1765
# res_path=../reranked/1765_queries/minilm/minilm_fairness_neg.trec

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec -task ${task}

# # reward pos 215
# res_path=../reranked/215_queries/minilm/minilm_fairness_pos.trec
# checkpoint=../checkpoints/minilm/minilm_fairness_pos.bin

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec -task ${task}

# # reward pos 1765
# res_path=../reranked/1765_queries/minilm/minilm_fairness_pos.trec

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec -task ${task}

# # reward both 215
# res_path=../reranked/215_queries/minilm/minilm_fairness_both.trec
# checkpoint=../checkpoints/minilm/minilm_fairness_both.bin

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec -task ${task}

# # reward both 1765
# res_path=../reranked/1765_queries/minilm/minilm_fairness_both.trec

# python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec -task ${task}

