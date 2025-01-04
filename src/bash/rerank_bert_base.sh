base_model=prajjwal1/bert-tiny
max_query_len=32
max_doc_len=221
batch_size=256
 
# original 215
res_path=../reranked/215_queries/berttiny/berttiny_original.trec
checkpoint=../checkpoints/berttiny/berttiny_original.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# original 1765
res_path=../reranked/1765_queries/berttiny/berttiny_original.trec

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# penalty neg 215
res_path=../reranked/215_queries/berttiny/berttiny_penalty_neg.trec
checkpoint=../checkpoints/berttiny/berttiny_penalty_neg.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# penalty neg 1765
res_path=../reranked/1765_queries/berttiny/berttiny_penalty_neg.trec

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# penalty pos 215
res_path=../reranked/215_queries/berttiny/berttiny_penalty_pos.trec
checkpoint=../checkpoints/berttiny/berttiny_penalty_pos.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# penalty pos 1765
res_path=../reranked/1765_queries/berttiny/berttiny_penalty_pos.trec

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# penalty both 215
res_path=../reranked/215_queries/berttiny/berttiny_penalty_both.trec
checkpoint=../checkpoints/berttiny/berttiny_penalty_both.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# penalty both 1765
res_path=../reranked/1765_queries/berttiny/berttiny_penalty_both.trec

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# reward neg 215
res_path=../reranked/215_queries/berttiny/berttiny_fairness_neg.trec
checkpoint=../checkpoints/berttiny/berttiny_fairness_neg.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# reward neg 1765
res_path=../reranked/1765_queries/berttiny/berttiny_fairness_neg.trec

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# reward pos 215
res_path=../reranked/215_queries/berttiny/berttiny_fairness_pos.trec
checkpoint=../checkpoints/berttiny/berttiny_fairness_pos.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# reward pos 1765
res_path=../reranked/1765_queries/berttiny/berttiny_fairness_pos.trec

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec

# reward both 215
res_path=../reranked/215_queries/berttiny/berttiny_fairness_both.trec
checkpoint=../checkpoints/berttiny/berttiny_fairness_both.bin

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec

# reward both 1765
res_path=../reranked/1765_queries/berttiny/berttiny_fairness_both.trec

python inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -test queries=/home/ir-bias/Shirin/target_queries/navid_neutrals/neutral_queries.tsv,docs=/home/ir-bias/Shirin/msmarco/data/collection.tsv,trec=/home/ir-bias/Shirin/target_queries/navid_neutrals/run.neutral_queries.trec

