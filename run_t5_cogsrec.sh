#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=320GB
#SBATCH --time=48:00:00
#SBATCH --job-name=t5_cogsrec
#SBATCH --output=t5_cogsrec_%A_%a.out
#SBATCH --array=0-4

module purge
module load cuda/11.1.74

MAX_TRAIN_DEPTH=3  # 3, 4, 5, 6, 7, 8, 9, 10, 11
((MIN_TEST_DEPTH=MAX_TRAIN_DEPTH+1))
EPOCHS=10  

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark COGS \
    --model_name_or_path t5-3b \
    --use_pretrained_weights True \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --source_prefix "translate English to English: " \
    --train_file data_cogs/recursion_splits/train_recursion_depth_from_0_to_$MAX_TRAIN_DEPTH.json \
    --test_file data_cogs/recursion_splits/test_recursion_depth_from_${MIN_TEST_DEPTH}_to_12.json \
    --gen_conditions_file data_cogs/recursion_splits/conditions_recursion_depth_from_${MIN_TEST_DEPTH}_to_12.json \
    --output_dir out_t5_3b_cogsrec_${MIN_TEST_DEPTH}_$SLURM_ARRAY_TASK_ID \
    --per_device_train_batch_size 32 \
    --per_device_eval_batch_size 32 \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 1024 \
    --max_source_length 1024 \
    --num_train_epochs $EPOCHS \
    --seed $SLURM_ARRAY_TASK_ID \
    --model_parallel \
    --predict_with_generate

echo "Done"
