"""
16.2.2021
Author: Shirin
"""
import csv
# from configs import DICT_PATH, EXPERIMENT_FP, RESULTS_SAVE_PATH
from liwc_document_calculate_bias import calculate_doc_score
import pickle
import liwc
import argparse


def find_top_n_docs(run_file_path, cutoff):
    """

    :param run_file:
    :return: top_n_docs: stores a dictionary of query_id and top_n doc_ids:
                {"query_id":[docic_1, docid_2, ..., docid_cutoff]}
    """
    top_n_docs = {}
    doc_ids = []
    with open(run_file_path, 'r') as run_file:
        for doc_counter, line in enumerate(run_file):
            list_line = line.split(" ")
            if int(list_line[3]) < cutoff+1:
                query_id = list_line[0]
                # print("finding top-{} docs of query id = {}".format(cutoff, query_id))
                doc_ids.append(list_line[2])
                top_n_docs[query_id] = doc_ids
            else:
                doc_ids = []
    return top_n_docs


def calculate_query_score_cutoff(doc_ids, fm_dictionary):
    """
    calculate the mean fm_score of each query
    based on its top_n retreived docs
    score = abs(mean(femail_score - mail_score))
    :return:
    """
    query_score = [0, 0, 0]
    for doc_idx in doc_ids:
        # query_score += dictionary[doc_idx]
        query_score = [(query_score[i] + fm_dictionary[int(doc_idx)][i]) for i in range(len(query_score))]
    query_score = [abs(score/len(doc_ids))*100 for score in query_score]
    return query_score


def calculate_score_cutoff(topn_docs_dict, fm_dictionary):

    total_score = [0, 0, 0]
    for counter, doc_ids in enumerate(topn_docs_dict.values()):
        # print("calculating score for query number {}".format(counter))
        query_score = calculate_query_score_cutoff(doc_ids, fm_dictionary)
        total_score[0] += query_score[0]
        total_score[1] += query_score[1]
        total_score[2] += query_score[2]
    total_score[0] = total_score[0] / len(topn_docs_dict)
    total_score[1] = total_score[1] / len(topn_docs_dict)
    total_score[2] = total_score[2] / len(topn_docs_dict)
    return total_score


def write_score_cutoffs(fm_dict, run_file_path, save_path):
    cutoff_list = [10,20]
    resulting_csv_row = {}
    # with open(save_path, "w") as result_file:

    for cutoff in cutoff_list:
        # print("cutoff = {}".format(cutoff))
        # print("creat topn docs dictionary")
        topn_docs_dict = find_top_n_docs(run_file_path, cutoff)
        fm_score = calculate_score_cutoff(topn_docs_dict, fm_dict)
        resulting_csv_row[cutoff] = [round(fm_score[2], 4), round(fm_score[0], 4),
                                    round(fm_score[1], 4), round(fm_score[0]-fm_score[1], 4)]
        
    print(resulting_csv_row[10][0])
    # print(resulting_csv_row[20][0])

        # writer = csv.writer(result_file)
        # writer.writerow(resulting_csv_row)
            # log = "cutoff {}-> total score: femail ={}, mail={}, femail - mail ={} \n"\
            #     .format(cutoff, fm_score[0], fm_score[1], fm_score[2])
            # result_file.write(log)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-experiment', type=str)
    args = parser.parse_args()

    EXPERIMENT = args.experiment
    EXPERIMENT_FP = "/mnt/data/shirin/bias_aware_loss_journal/reranked/1765_queries/electrasmall/pointwise/regression/"+EXPERIMENT
    DICT_PATH = "/mnt/data/shirin/gender_disentanglement_journal/data/liwc/"+"liwccollection_bias.pkl"
# liwc mean for cutoffs
    RESULTS_SAVE_PATH = "/mnt/data/shirin/bias_aware_loss_journal/biases/fm_scores_"+EXPERIMENT

    # print("start creating and saving the fm_dictionary of liwc for all of the collection documents")
    collection_path = "/mnt/data/shirin/msmarco/data/collection.tsv"
    parse, _ = liwc.load_token_parser('/mnt/data/shirin/gender_disentanglement_journal/data/liwc/LIWC2015Dictionary.dic')
    with open(DICT_PATH, "rb") as file_to_read:
        documents_bias = pickle.load(file_to_read)
    # documents_bias = {}
    # empty_cnt = 0
    # with open(collection_path) as fr:
    #     for i, line in enumerate(fr):
    #         if i % 100000 == 0:
    #             print(i)
    #         vals = line.strip().split('\t')
    #         docid = int(vals[0])
    #         if len(vals) == 2:
    #             _text = vals[1]
    #         else:
    #             _text = ""
    #             empty_cnt += 1
    #         documents_bias[docid] = calculate_doc_score(_text, parse)
    # with open(DICT_PATH, 'wb') as file_to_write:
    #     pickle.dump(documents_bias, file_to_write)
    
    run_file_path = EXPERIMENT_FP
    # print(EXPERIMENT_FP)
    save_path = RESULTS_SAVE_PATH + ".csv"
    write_score_cutoffs(documents_bias, run_file_path, save_path)
    # calculate_total_score_lambdas()

