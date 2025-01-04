file_path = "/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_6M.tsv"
write_path = "/mnt/data/shirin/bias_aware_loss_journal/data/dataset_journal_pointwise_6M.tsv"


with open(file_path, 'r') as file_to_read,\
    open(write_path, 'w') as file_to_write:
        positives = []
        for i, line in enumerate(file_to_read):
            if i % 1000 ==0:
                print(i)
            query, doc_pos, doc_neg, bias_pos, bias_neg, fairness_pos, fairness_neg = line.strip('\n').split('\t')
            if doc_pos not in positives:
                newline_pos = query + "\t" + doc_pos + "\t" + "1" + "\t" + bias_pos + "\t" + fairness_pos + "\n"
                positives.append(doc_pos)
                file_to_write.write(newline_pos)
                
            newline_neg = query + "\t" + doc_neg + "\t" + "0" + "\t" + bias_neg + "\t" + fairness_neg + "\n"
            file_to_write.write(newline_neg)