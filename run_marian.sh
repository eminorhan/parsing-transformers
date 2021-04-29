#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=180GB
#SBATCH --time=48:00:00
#SBATCH --array=0
#SBATCH --job-name=marian_fide_scan
#SBATCH --output=marian_fide_scan_%A_%a.out

module purge
module load cuda/11.1.74

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --model_name_or_path Helsinki-NLP/opus-mt-fi-de \
    --use_pretrained_weights True \
    --do_train \
    --do_predict \
    --source_lang fi \
    --target_lang de \
    --train_file data_scan/add_jump/train.json \
    --test_file data_scan/add_jump/test.json \
    --output_dir tmp_marian_fide_addjump_pre \
    --per_device_train_batch_size 64 \
    --per_device_eval_batch_size 64 \
    --overwrite_output_dir \
    --save_steps 250000 \
    --max_target_length 512 \
    --num_train_epochs 20 \
    --predict_with_generate

echo "Done"
