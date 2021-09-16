# Semantic parsing with pretrained transformers

## Results

**NB:** This README is not up-to-date. 

We finetuned/trained the following models until convergence. Detailed results are in the [`results`](https://github.com/eminorhan/parsing-transformers/tree/master/results) folder. 

### COGS

| model                    | average |
| ------------------       |:-------:|
| `t5_3b_scratch`          | 0.0     |
| `t5_3b_pretrained`       | 84.1    |
| `mt5_xl_pretrained` 	    | 84.6    |
| `t5_xl_bfd_pretrained`   | 0.0     |
| `marian_defr_scratch`    | 62.7    |
| `marian_defr_pretrained` | 83.4    |

### SCAN

| model                    | add jump | add turn left | jump around right | around right | opposite right | right | length | average |
| ------------------       |:--------:|:-------------:|:-----------------:|:------------:|:--------------:|:-----:|:------:|:------:|
| `t5_3b_scratch`          | 0.0  | 0.1         | 0.0               | 0.0          | 0.0            | 0.0   | 0.1    | 0.0 |
| `t5_3b_pretrained`       | 96.0 | 94.5        | 100.0             | 37.0         | 99.5           | 98.6  | 8.3    | 76.3 |
| `mt5_xl_pretrained` 	    | 57.5 | 97.6        | 99.9              | 80.9         | 88.7           | 87.3  | 5.4    | 73.9 |
| `t5_xl_bfd_pretrained`   | 0.0  | 0.1         | 0.0               | 0.0          | 0.0            | 0.1   | 0.0    | 0.0 |
| `marian_defr_scratch`    | 2.9  | 95.2        | 100.0             | 33.1         | 89.8           | 82.1  | 12.8   | 59.4 |
| `marian_defr_pretrained` | 62.7 | 83.5        | 96.3              | 45.0         | 99.1           | 92.4  | 15.0   | 70.6 |
