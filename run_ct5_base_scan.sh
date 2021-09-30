#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=200GB
#SBATCH --time=48:00:00
#SBATCH --job-name=ct5_scan
#SBATCH --output=ct5_scan_%A_%a.out
#SBATCH --array=0-4

module purge
module load cuda/11.1.74

SPLIT=add_jump  # add_jump, add_turn_left, around_right, jump_around_right, length, opposite_right, right
EPOCHS=50

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark SCAN \
    --model_name_or_path Salesforce/codet5-base \
    --tokenizer_name Salesforce/codet5-base \
    --use_pretrained_weights True \
    --output_dir out_ct5_${SPLIT}_${EPOCHS}_$SLURM_ARRAY_TASK_ID \
    --train_file data_scan/$SPLIT/train.json \
    --test_file data_scan/$SPLIT/test.json \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --source_prefix "" \
    --per_device_train_batch_size 32 \
    --per_device_eval_batch_size 32 \
    --num_train_epochs $EPOCHS \
    --seed $SLURM_ARRAY_TASK_ID \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 512 \
    --max_source_length 512 \
    --learning_rate 0.0001 \
    --predict_with_generate

echo "Done"
