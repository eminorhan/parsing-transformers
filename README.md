# Semantic parsing with pretrained transformers

## Results

Detailed results are in the [`results`](https://github.com/eminorhan/parsing-transformers/tree/master/results) folder. 

# SCAN

We selected the number of finetuning/training epochs based on the average performance across all splits.

| model              | add jump | add turn left | jump around right | around right | opposite right | right | length | average |
| ------------------ |:--------:|:-------------:|:-----------------:|:------------:|:--------------:|:-----:|:------:|:------:|
| `t5_3b_scratch`    | 0.0      | 0.1           | 0.0               | 0.0          | 0.0            | 0.0   | 0.1    |  |
| `t5_3b_pretrained` | 92.2     | 79.0          | 90.6              | 48.2         | 96.5           | 94.5  | 0.1    |  |
| `marian_defr_scratch`    | 2.9  | 95.2        | 100.0             | 33.1         | 89.8           | 82.1  | 12.8   | 59.4 |
| `marian_defr_pretrained` | 62.7 | 83.5        | 96.3              | 45.0         | 99.1           | 92.4  | 15.0   | 70.6 |

