## A Generalizable Framework for Bias Mitigation in Dense Neural Rankers

This repository includes the code and experimental details for the paper *"A Generalizable Framework for Bias Mitigation in Dense Neural Rankers."* Dense neural retrievers, powered by pre-trained language models, have significantly enhanced information retrieval (IR) systems by capturing complex semantic relationships. However, despite their retrieval effectiveness, these models often exhibit gender biases in their ranking results, unintentionally perpetuating societal stereotypes. Existing mitigation strategies primarily address data imbalances or introduce architectural changes but frequently overlook the optimization objective as a core source of bias amplification. This paper introduces a fairness-aware framework that integrates bias mitigation directly into the loss function of dense neural rankers, employing customizable penalty and reward mechanisms to dynamically balance relevance and fairness objectives during training. By incorporating fairness constraints into both pointwise and pairwise ranking paradigms, the framework ensures that the ranker is guided to optimize for both relevance and fairness simultaneously. Extensive experiments on benchmark datasets demonstrate that this approach significantly reduces gender bias while maintaining competitive retrieval effectiveness, and its generalizability is confirmed across different pre-trained language models. Furthermore, the proposed framework consistently outperforms state-of-the-art baselines in balancing fairness and relevance objectives. The network architecture and loss function formulations are designed to explicitly balance these dual goals without requiring changes to the underlying neural model architecture. The figure below illustrates the architecture of the fairness-aware neural ranking model.
<div align="center">
  

  <img src="https://github.com/genderdisen/genderdisen/blob/main/results/network_arch.png" width="500" height="300"/>
</div>



<div align="center">
  
##### Figure 1. Overview of the proposed neural disentanglement architecture.




### Train
To train the original model (without disentanglement), you need to run [my_train_priginal.py](https://github.com/genderdisen/genderdisen/blob/main/src/my_train_original.py)
with the following setup:

###### Original minilm-L6 model:

```
python my_train_original.py -vocab sentence-transformers/msmarco-MiniLM-L6-cos-v5 -pretrain sentence-transformers/msmarco-MiniLM-L6-cos-v5 -res <results_path> -save <checkpoint_save_path> -n_warmup_steps 160000 -batch_size 16 -attribute_dim 100 -optimizer adam -lr 3e-6
```

###### Original bert-mini model:
```
python my_train_original.py -vocab prajjwal1/bert-mini -pretrain prajjwal1/bert-mini -res <results_path> -save <checkpoint_save_path> -n_warmup_steps 160000 -batch_size 16 -lr 3e-6 -max_query_len 32 -max_doc_len 221

```

To train the disentanglement model , you need to run [my_train_disentangled.py](https://github.com/genderdisen/genderdisen/blob/main/src/my_train_disentangled.py)
with the following setup:
###### Disentangled minilm-L6 model:
```
python my_train_disentangled.py -vocab sentence-transformers/msmarco-MiniLM-L6-cos-v5 -pretrain sentence-transformers/msmarco-MiniLM-L6-cos-v5 -res <results_path> -save <checkpoint_save_path> -n_warmup_steps 160000 -batch_size 16 -attribute_dim 50 -optimizer adam -lr 3e-4
```

###### Disentangled bert-mini model:

```
python my_train_disentangled.py -vocab prajjwal1/bert-mini -pretrain prajjwal1/bert-mini -res .<results_path> -save <checkpoint_save_path> -n_warmup_steps 160000 -batch_size 16 -attribute_dim 50 -optimizer 'adam' -lr 3e-5 -max_query_len 32 -max_doc_len 221 -alpha 1 -betta 1 -gamma 1
```


### inference

To do the inference, and rerank-the top-1000 BM25 documents, you need to run [inference.py](https://github.com/genderdisen/genderdisen/blob/main/src/inference.py), and [inference_disentanglement.py](https://github.com/genderdisen/genderdisen/blob/main/src/inference_disentanglement.py) with the following setup for the original and the disentangled models, respectively.

###### Original minilm model:

```
python inference.py -task ranking -model bert -max_input 600000000 -vocab sentence-transformers/msmarco-MiniLM-L6-cos-v5 -pretrain sentence-transformers/msmarco-MiniLM-L6-cos-v5  -checkpoint <checkpoint_save_path> -res <result_path> -max_query_len 32 -max_doc_len 221 -batch_size 256 -test queries=<test_query_path>,docs=<collection_path>,trec=<run_path>
```

###### Original bert-mini model:

```
python inference.py -task ranking -model bert -max_input 600000000 -vocab prajjwal1/bert-mini -pretrain prajjwal1/bert-mini -checkpoint ${save_path} -res ${res_path} -max_query_len 32 -max_doc_len 221 -batch_size 256 -test queries=<test_query_path>,docs=<collection_path>,trec=<run_path>
```


###### Disentangled minilm model:

```
python inference_disentanglement.py -task ranking -model bert -max_input 600000000 -vocab sentence-transformers/msmarco-MiniLM-L6-cos-v5 -pretrain sentence-transformers/msmarco-MiniLM-L6-cos-v5  -checkpoint <checkpoint_save_path> -res <result_path> -max_query_len 32 -max_doc_len 221 -batch_size 256 -attribute_dim 50 -test queries=<test_query_path>,docs=<collection_path>,trec=<run_path>
```

###### Disentangled bert-mini model:

```
python inference_disentanglement.py -task ranking -model bert -max_input 600000000 -vocab prajjwal1/bert-mini -pretrain prajjwal1/bert-mini -checkpoint ${save_path} -res ${res_path} -max_query_len 32 -max_doc_len 221 -batch_size 256 -attribute_dim 50 -test queries=<test_query_path>,docs=<collection_path>,trec=<run_path>
```

The re-ranled run-files for the 215, qnd 1765 queries are provided in the [runs](https://github.com/genderdisen/genderdisen/tree/main/runs) directory.
### evaluation

###### MRR

You may use [calculate_mrr.py](https://github.com/genderdisen/genderdisen/blob/main/src/calculate_mrr.py) as follows to calculate the MRR measure.

```
python calculate_mrr.py -qrels <qrels_path> -run <run_path>
```

###### ARaB
In order to calculate the ARaB metrics, you need to first run [documents_calculate_bias.py](https://github.com/genderdisen/genderdisen/blob/main/src/documents_calculate_bias.py) to calculate bias of each of the documents in the collectio. then you need to run [runs_calculate_bias.py](https://github.com/genderdisen/genderdisen/blob/main/src/runs_calculate_bias.py), anf finally [model_calculate_bias.py](https://github.com/genderdisen/genderdisen/blob/main/src/model_calculate_bias.py).

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

To calculate the LIWC metric, you first need to get the LIWC dictionary from [their website](https://www.liwc.app) and then run [calculate_liwc_biases.py](https://github.com/genderdisen/genderdisen/blob/main/src/LIWC/calculate_liwc_biases.py).


