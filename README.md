# Semantic parsing with pretrained transformers

This repository contains the code for reproducing the results reported in the following paper:

Orhan AE (2021) [Compositional generalization in semantic parsing with pretrained transformers.](https://arxiv.org/abs/2109.15101) arXiv:2109.15101.

Please see the slurm scripts inside the [`scripts`](https://github.com/eminorhan/parsing-transformers/tree/master/scripts) directory for replicating each experiment reported in the paper (11 models x 2 benchmarks = 22 experiments in total). The file names should be self-explanatory. All experiments use the same code base contained in [`run_translation.py`](https://github.com/eminorhan/parsing-transformers/blob/master/run_translation.py), which is modified from the [translation example](https://github.com/huggingface/transformers/tree/master/examples/pytorch/translation) in the Huggingface examples repository. The output files for each experiment can be found in the [`results`](https://github.com/eminorhan/parsing-transformers/tree/master/results) directory.

