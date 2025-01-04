## A Generalizable Framework for Bias Mitigation in Dense Neural Rankers

This repository includes the code and experimental details for the paper *"A Generalizable Framework for Bias Mitigation in Dense Neural Rankers."* Dense neural retrievers, powered by pre-trained language models, have significantly enhanced information retrieval (IR) systems by capturing complex semantic relationships. However, despite their retrieval effectiveness, these models often exhibit gender biases in their ranking results, unintentionally perpetuating societal stereotypes. Existing mitigation strategies primarily address data imbalances or introduce architectural changes but frequently overlook the optimization objective as a core source of bias amplification. This paper introduces a fairness-aware framework that integrates bias mitigation directly into the loss function of dense neural rankers, employing customizable penalty and reward mechanisms to dynamically balance relevance and fairness objectives during training. By incorporating fairness constraints into both pointwise and pairwise ranking paradigms, the framework ensures that the ranker is guided to optimize for both relevance and fairness simultaneously. Extensive experiments on benchmark datasets demonstrate that this approach significantly reduces gender bias while maintaining competitive retrieval effectiveness, and its generalizability is confirmed across different pre-trained language models. Furthermore, the proposed framework consistently outperforms state-of-the-art baselines in balancing fairness and relevance objectives. The network architecture and loss function formulations are designed to explicitly balance these dual goals without requiring changes to the underlying neural model architecture. The figure below illustrates the architecture of the fairness-aware neural ranking model.
<div align="center">
  

  <img src="https://github.com/fairnesspaper/fairnesspaper/blob/main/baselines.png" width="500" height="300"/>
</div>
  
##### Figure 1. Comparison of our proposed approach with the state-of-the-art methods on the 215-query and 1,765-query datasets based on the best `fair' pairwise ranker using the "BERT-mini" base model. This ranker is the same as the pairwise ranker reported in Tables 9 and 10. We note negative values on the left side of each figure and positive values on the right side are desirable.


### Train
To train the original model (without prenalty, or reward), you need to run [my_train_priginal.py](https://github.com/fairnesspaper/fairnesspaper/blob/main/src/my_train_original.py).
with the following setup:

###### Original pairwise model:

```
python ../my_train_original.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps 160000 -batch_size 16 -lr 3e-6 -task ranking -train ${dataset}
```

###### Original pointwise model:
```
python ../my_train_original_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr 3e-6 -max_doc_len 221 -max_query_len 32 -task classification -train ${dataset}

```

###### Regularized Pairwise Model:
```
experiment=penalty_pos
python ../train_regularized.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -train ${dataset}
```


###### Regularized Pointwise Model:

```
experiment=penalty_neg
python ../train_regularized_regression.py -vocab ${base_model} -pretrain ${base_model} -res ${res_path} -save ${save_path} -n_warmup_steps ${n_warmup_steps} -batch_size ${batch_size} -lr ${learning_rate} -experiment ${experiment} -max_doc_len ${max_doc_len} -max_query_len ${max_query_len} -task ${task} -train ${dataset} -regularizer_neg ${regularizer_neg} -regularizer_pos ${regularizer_pos}

```

Experiment could be a choice of "penalty_pos" for to apply penalty to the relevant documents, "penalty_neg" to apply penalty to the irrelevant documents, or "penalty_both" to apply penalty to both relevant, and irrelevant documents. Similarly, "reward_pos", "reward_neg", and "reward_both" are the experiments for applying reward to the relevant, irrelevant, and both documents, respectively.

### inference

To do the inference, and rerank-the top-1000 BM25 documents, you need to run [inference.py](https://github.com/fairnesspaper/fairnesspaper/blob/main/src/inference.py) with the following setup.


```
python ../inference.py -vocab ${base_model} -pretrain ${base_model} -max_query_len ${max_query_len} -max_doc_len ${max_doc_len} -batch_size ${batch_size} -checkpoint ${checkpoint} -res ${res_path} -task ${task} -test queries=${queries},docs=${docs},trec=${trec}

```

### evaluation

###### MRR

You may use [calculate_mrr.py](https://github.com/fairnesspaper/fairnesspaper/blob/main/src/calculate_mrr.py) as follows to calculate the MRR measure.

```
python calculate_mrr.py -qrels <qrels_path> -run <run_path>
```

###### ARaB
In order to calculate the ARaB metrics, you need to first run [documents_calculate_bias.py](https://github.com/fairnesspaper/fairnesspaper/blob/main/src/documents_calculate_bias.py) to calculate bias of each of the documents in the collectio. then you need to run [runs_calculate_bias.py](https://github.com/fairnesspaper/fairnesspaper/blob/main/src/runs_calculate_bias.py), and finally [model_calculate_bias.py](https://github.com/fairnesspaper/fairnesspaper/blob/main/src/model_calculate_bias.py).

###### NFair
For calculating the NFaiR metric, you need to run this command as mentioned in the [NFaiRR GitHub repository](https://github.com/CPJKU/FairnessRetrievalResults/tree/main/measurement).

Calculating dcument neutrality scores: 
```
python3 calc_documents_neutrality.py --collection-path [PATH_TO_TSV_COLLECTION] --representative-words-path ../resources/wordlist_gender_representative.txt --threshold 1 --out-file processed/collection_neutralityscores.tsv
```

Calculating model fairness:
```
python metrics_fairness.py --collection-neutrality-path processed/collection_neutralityscores.tsv --backgroundrunfile sample_trec_runs/msmarco_passage/BM25.run --runfile sample_trec_runs/msmarco_passage/advbert_L4.run
```
###### LIWC

To calculate the LIWC metric, you first need to get the LIWC dictionary from [their website](https://www.liwc.app) and then run [calculate_liwc_biases.py](https://github.com/fairnesspaper/fairnesspaper/blob/main/src/LIWC/calculate_liwc_biases.py).


