#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=32GB
#SBATCH --time=48:00:00
#SBATCH --job-name=t5_scan
#SBATCH --output=t5_scan_%A_%a.out
#SBATCH --array=0-2

module purge
module load cuda/11.1.74

SPLIT=right  # add_jump, add_turn_left, around_right, jump_around_right, length, opposite_right, right
EPOCHS=15  # 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, etc.

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark SCAN \
    --use_pretrained_weights True \
    --model_name_or_path t5-3b \
    --output_dir out_t5_3b_${SPLIT}_${EPOCHS}_$SLURM_ARRAY_TASK_ID \
    --train_file data_scan/$SPLIT/train.json \
    --test_file data_scan/$SPLIT/test.json \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --source_prefix "translate English to English: " \
    --per_device_train_batch_size 32 \
    --per_device_eval_batch_size 32 \
    --num_train_epochs $EPOCHS \
    --seed $SLURM_ARRAY_TASK_ID \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 512 \
    --max_source_length 512 \
    --model_parallel \
    --predict_with_generate

echo "Done"
