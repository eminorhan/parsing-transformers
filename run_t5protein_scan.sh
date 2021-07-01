#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=320GB
#SBATCH --time=48:00:00
#SBATCH --array=0
#SBATCH --job-name=t5protein_scan
#SBATCH --output=t5protein_scan_%A_%a.out

module purge
module load cuda/11.1.74

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark SCAN \
    --model_name_or_path Rostlab/prot_t5_xl_bfd \
    --tokenizer_name Rostlab/prot_t5_xl_bfd \
    --use_fast_tokenizer False \
    --output_dir out_prot_t5_xl_bfd_around_right_pre \
    --train_file data_scan/around_right/train_protein.json \
    --test_file data_scan/around_right/test_protein.json \
    --use_pretrained_weights True \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --source_prefix "" \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 16 \
    --num_train_epochs 2 \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 1024 \
    --max_source_length 1024 \
    --model_parallel \
    --predict_with_generate

echo "Done"
