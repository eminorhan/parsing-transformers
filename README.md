# Semantic parsing with pretrained transformers

## Results

Detailed results are in the [`results`](https://github.com/eminorhan/parsing-transformers/tree/master/results) folder. 

# SCAN

We selected the number of finetuning/training epochs based on the `around right` split and used the same number of finetuning/training epochs for the remaining splits. This is similar to the strategy used in [Furer, van Zee, et al. (2020)](https://arxiv.org/abs/2007.08970).

| model              | add jump | add turn left | jump around right | around right | opposite right | right | length |
| ------------------ |:--------:|:-------------:|:-----------------:|:------------:|:--------------:|:-----:|:------:|
| `t5_3b_scratch`    | 0.0      | 0.1           | 0.0               | 0.0          | 0.0            | 0.0   | 0.1    |
| `t5_3b_pretrained` | 92.2     | 79.0          | 90.6              | 48.2         | 96.5           | 94.5  | 0.1    |

| `marian_defr_scratch`    | 4.0  | 98.9        | 100.0             | 33.9         | 62.7           | 55.6  | 11.6   | 
| `marian_defr_pretrained` | 53.9 | 77.2        | 99.7              | 47.8         | 99.7           | 86.3  | 14.2   |

| `marian_esit_pretrained` | 61.9 | 62.5        | 59.1              | 42.3         | 86.5           | 7.5   | 12.7   |

| `marian_finl_pretrained` | 55.5 | 66.1        | 75.7              | 39.4         | 92.7           | 52.9  | 14.1   |

| `marian_hufi_pretrained` | 48.7 | 96.4        | 99.5              | 46.4         | 100.0          | 83.6  | 14.5   |

| `marian_fics_pretrained` | ---- | ----        | ----              | ----         | -----          | ----  | ----   |
