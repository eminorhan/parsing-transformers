# Semantic parsing with pretrained transformers

## Results

Detailed results are in the [`results`](https://github.com/eminorhan/parsing-transformers/tree/master/results) folder. 

# SCAN

We selected the number of finetuning/training epochs based on the `around right` split and used the same number of finetuning/training epochs for the remaining splits. This is similar to the strategy used in [Furer, van Zee, et al. (2020)](https://arxiv.org/abs/2007.08970).

| model              | add jump | add turn left | jump around right | around right | opposite right | right | length |
| ------------------ |:--------:|:-------------:|:-----------------:|:------------:|:--------------:|:-----:|:------:|
| `t5_3b_pretrained` | 92.2     | 79.0          | 90.6              | 48.2         | 96.5           | 94.5  | 0.1    |
| `t5_3b_scratch`    | 0.0      | 0.1           | 0.0               | 0.0          | 0.0            | 0.0   | 0.1    |
