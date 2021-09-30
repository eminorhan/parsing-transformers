#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=320GB
#SBATCH --time=48:00:00
#SBATCH --job-name=mt5_xl_scan
#SBATCH --output=mt5_xl_scan_%A_%a.out
#SBATCH --array=0-2

module purge
module load cuda/11.1.74

SPLIT=right # add_jump, add_turn_left, around_right, jump_around_right, length, opposite_right, right
EPOCHS=12 

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark SCAN \
    --use_pretrained_weights True \
    --model_name_or_path google/mt5-xl \
    --output_dir out_mt5_xl_${SPLIT}_${EPOCHS}_$SLURM_ARRAY_TASK_ID \
    --train_file data_scan/$SPLIT/train.json \
    --test_file data_scan/$SPLIT/test.json \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 8 \
    --num_train_epochs $EPOCHS \
    --seed $SLURM_ARRAY_TASK_ID \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 512 \
    --max_source_length 512 \
    --predict_with_generate \
    --model_parallel

echo "Done"
