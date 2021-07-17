#!/bin/bash

#SBATCH --account=cds
#SBATCH --exclude=gr069
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=320GB
#SBATCH --time=48:00:00
#SBATCH --array=0
#SBATCH --job-name=mt5_scan
#SBATCH --output=mt5_scan_%A_%a.out

module purge
module load cuda/11.1.74

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark SCAN \
    --model_name_or_path google/mt5-xl \
    --output_dir out_mt5_xl_add_jump_pre \
    --train_file data_scan/add_jump/train.json \
    --test_file data_scan/add_jump/test.json \
    --use_pretrained_weights True \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 16 \
    --num_train_epochs 1 \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 512 \
    --max_source_length 512 \
    --model_parallel \
    --predict_with_generate

echo "Done"
