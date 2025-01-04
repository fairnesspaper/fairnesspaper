import csv
from calculate_doc_bias import DocBias
from document_neutrality import DocumentNeutrality


def create_train_data(msmarco_triple_path, dataset_savepath, bias_meter, fairness_meter):
    max_samples = 12000000
    with open(msmarco_triple_path, 'r') as msmarco_dataset,\
         open(dataset_savepath, 'w') as my_dataset:
        dataset_bias = []
        writer = csv.writer(my_dataset, delimiter='\t')
        for n, line in enumerate(msmarco_dataset):
            if n%1000 == 0:
                print("sample {}".format(n))
            if n > max_samples:
                break
            query, doc_pos, doc_neg = line.strip('\n').split('\t')
            bias_negative = bias_meter.get_bias(bias_meter.get_tokens(doc_neg))
            bias_positive = bias_meter.get_bias(bias_meter.get_tokens(doc_pos))

            doc_pos_tokens = doc_pos.lower().split(' ') # it is expected that the input document is already cleaned and pre-tokenized
            doc_neg_tokens = doc_neg.lower().split(' ') # it is expected that the input document is already cleaned and pre-tokenized
            neutrality_pos = fairness_meter.get_neutrality(doc_pos_tokens)
            neutrality_neg = fairness_meter.get_neutrality(doc_neg_tokens)

            dataset_bias.append([query, doc_pos, doc_neg, abs(bias_positive[0]), abs(bias_negative[0]), neutrality_pos, neutrality_neg])
        writer.writerows(dataset_bias)


if __name__ == "__main__":
    gendered_vocab_path = "/mnt/data/shirin/gender_disentanglement_journal/resources/wordlist_genderspecific.txt"
    bias_meter = DocBias(gendered_vocab_path)
    fairness_meter = DocumentNeutrality(representative_words_path="./NFaiR/wordlist_gender_representative.txt",
                                  threshold=1,
                                  groups_portion={'f':0.5, 'm':0.5})
    
    msmarco_triple_path = "/mnt/data/shirin/msmarco/triples.train.small.tsv"
    dataset_savepath = "/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_12M.tsv"
    create_train_data(msmarco_triple_path, dataset_savepath, bias_meter, fairness_meter)