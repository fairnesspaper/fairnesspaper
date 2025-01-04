import torch


def bias_regularized_margin_ranking_loss(score_pos, score_neg, regularizer_neg=None, 
                                             regularizer_pos=None, bias_neg=None, bias_pos=None):
    """
    implementation of the a regularized version of the multilable margine loss, which is used in the
    repbert paper.

    1-[\SUM REL(Q,D_J^+)-(REL(Q,D_J^-)+LAMBDA BIAS(D_J^-))]
    BIAS(D_J^-) = ABS(boolean bias)
    Args:
        input1: rel(q, d+)
        input2: rel(q, d-)
        regularizer: scalar
        bias: bias of batch
    Returns:

    """
    # neg - pos to cover the minus sign of target in the original formula
    if bias_pos is not None and bias_neg is not None:
        # both
        diff = score_neg - score_pos + regularizer_neg * bias_neg  - regularizer_pos * bias_pos 
    elif bias_pos is None and bias_neg is not None:
        # neg
        diff = score_neg + regularizer_neg * bias_neg - score_pos
    elif bias_neg is None and bias_pos is not None:
        # pos
        diff = score_neg - score_pos - regularizer_pos * bias_pos
    else:
        ValueError("something is wrong in loss")

    input_loss = diff + torch.ones(score_pos.size()).to('cuda')
    max_0 = torch.nn.functional.relu(input_loss)
    return torch.mean(max_0)


def fairness_regularized_margin_ranking_loss(score_pos, score_neg, regularizer_neg=1, 
                                             regularizer_pos=1, fairness_neg=None, fairness_pos=None):
    """
    implementation of the a regularized version of the multilable margine loss, which is used in the
    repbert paper.

    1-[\SUM REL(Q,D_J^+)-(REL(Q,D_J^-)-LAMBDA FAIRNESS(D_J^-))]
    FAIRNESS(D_J^-) = NFaiR(doc_neg)
    Args:
        input1: rel(q, d+)
        input2: rel(q, d-)
        regularizer: scalar
        fairness: NFaiR of each document
    Returns:

    """
    # input2 - input1 to cover the minus sign of target in the original formula
    if fairness_pos is not None and fairness_neg is not None:
        # both
        diff = score_neg - score_pos - regularizer_neg * fairness_neg + regularizer_pos * fairness_pos 
    elif fairness_pos is None and fairness_neg is not None:
        # neg
        diff = score_neg - regularizer_neg * fairness_neg - score_pos
    elif fairness_neg is None and fairness_pos is not None:
        # pos
        diff = score_neg - score_pos + regularizer_pos * fairness_pos
    else:
        ValueError("something is wrong with the fairnesses")

    input_loss = diff + torch.ones(score_pos.size()).to('cuda')
    max_0 = torch.nn.functional.relu(input_loss)
    return torch.mean(max_0)
