python metrics_fairness.py --collection-neutrality-path /mnt/data/shirin/msmarco/collection_neutralityscores.tsv --backgroundrunfile /mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec --runfile /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda0.1.trec

python metrics_fairness.py --collection-neutrality-path /mnt/data/shirin/msmarco/collection_neutralityscores.tsv --backgroundrunfile /mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec --runfile /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda0.5.trec

python metrics_fairness.py --collection-neutrality-path /mnt/data/shirin/msmarco/collection_neutralityscores.tsv --backgroundrunfile /mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec --runfile /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1.trec

python metrics_fairness.py --collection-neutrality-path /mnt/data/shirin/msmarco/collection_neutralityscores.tsv --backgroundrunfile /mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec --runfile /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda2.trec

python metrics_fairness.py --collection-neutrality-path /mnt/data/shirin/msmarco/collection_neutralityscores.tsv --backgroundrunfile /mnt/data/shirin/target_queries/social_neutrals/msmarco/run.neutral_queries.trec --runfile /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/electrasmall/pointwise/regression/electrasmall_penalty_pos_1_lambda5.trec


# python metrics_fairness.py --collection-neutrality-path /mnt/data/shirin/msmarco/collection_neutralityscores.tsv --backgroundrunfile /mnt/data/shirin/target_queries/social_neutrals/msmarco/msmarco/run.neutral_queries.trec --runfile /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/bertmini/pointwise/regression/bertmini_fairness_pos_1.trec

# python metrics_fairness.py --collection-neutrality-path /mnt/data/shirin/msmarco/collection_neutralityscores.tsv --backgroundrunfile /mnt/data/shirin/target_queries/social_neutrals/msmarco/msmarco/run.neutral_queries.trec --runfile /mnt/data/shirin/bias_aware_loss_journal/reranked/215_queries/bertmini/pointwise/regression/bertmini_fairness_both_1.trec
