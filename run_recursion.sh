#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --cpus-per-task=12
#SBATCH --mem=250GB
#SBATCH --time=48:00:00
#SBATCH --array=0
#SBATCH --job-name=t5_cogs
#SBATCH --output=t5_cogs_%A_%a.out

module purge
module load cuda/11.1.74

((MAX_TRAIN_DEPTH=10))
((MIN_TEST_DEPTH=MAX_TRAIN_DEPTH+1))

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --model_name_or_path t5-3b \
    --use_pretrained_weights True \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --finetune_target_lang mentalese \
    --source_prefix "translate English to English: " \
    --train_file data/recursion_splits/train_recursion_depth_from_0_to_$MAX_TRAIN_DEPTH.json \
    --test_file data/recursion_splits/test_recursion_depth_from_${MIN_TEST_DEPTH}_to_12.json \
    --gen_conditions_file data/recursion_splits/conditions_recursion_depth_from_${MIN_TEST_DEPTH}_to_12.json \
    --output_dir tmp_t5_large_pre_recursion_$MAX_TRAIN_DEPTH \
    --per_device_train_batch_size 10 \
    --per_device_eval_batch_size 10 \
    --overwrite_output_dir \
    --save_steps 250000 \
    --max_target_length 1024 \
    --num_train_epochs 2 \
    --model_parallel \
    --predict_with_generate

echo "Done"
