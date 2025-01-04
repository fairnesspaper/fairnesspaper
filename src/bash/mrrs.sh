python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda0.1.trec 

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda0.5.trec 

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1.trec 

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda2.trec 

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda5.trec 

echo "Cutoff 20"

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda0.1.trec -metric mrr_cut_20

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda0.5.trec -metric mrr_cut_20

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1.trec -metric mrr_cut_20

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda2.trec -metric mrr_cut_20

python ../calculate_mrr.py -qrels /mnt/data/shirin/bias_aware_loss_journal/runs/qrels.dev.tsv -run /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda5.trec -metric mrr_cut_20