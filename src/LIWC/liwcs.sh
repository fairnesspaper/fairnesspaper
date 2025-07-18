# echo "original"
python calculate_liwc_biases.py -experiment "electrasmall_penalty_pos_1_lambda0.1.trec"
# python calculate_liwc_biases.py -experiment "bertmini_original_2.trec"
# python calculate_liwc_biases.py -experiment "bertmini_original_3.trec"
# python calculate_liwc_biases.py -experiment "bertmini_original_4.trec"
# python calculate_liwc_biases.py -experiment "bertmini_original_5.trec"

# echo "penalty neg"
python calculate_liwc_biases.py -experiment "electrasmall_penalty_pos_1_lambda0.5.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_neg_2.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_neg_3.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_neg_4.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_neg_5.trec"

# echo "penalty pos"
python calculate_liwc_biases.py -experiment "electrasmall_penalty_pos_1_lambda2.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_pos_2.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_pos_3.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_pos_4.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_pos_5.trec"

# echo "penaly both"
python calculate_liwc_biases.py -experiment "electrasmall_penalty_pos_1_lambda5.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_both_2.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_both_3.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_both_4.trec"
# python calculate_liwc_biases.py -experiment "bertmini_penalty_both_5.trec"

echo "reward neg"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_neg_1.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_neg_2.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_neg_3.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_neg_4.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_neg_5.trec"

echo "reward pos"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_pos_1.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_pos_2.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_pos_3.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_pos_4.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_pos_5.trec"

echo "reward both"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_both_1.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_both_2.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_both_3.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_both_4.trec"
# python calculate_liwc_biases.py -experiment "bertmini_fairness_both_5.trec"


