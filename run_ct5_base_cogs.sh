#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=200GB
#SBATCH --time=48:00:00
#SBATCH --job-name=ct5_cogs
#SBATCH --output=ct5_cogs_%A_%a.out
#SBATCH --array=1-4

module purge
module load cuda/11.1.74

EPOCHS=10  # 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, etc.

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark COGS \
    --model_name_or_path Salesforce/codet5-base \
    --tokenizer_name Salesforce/codet5-base \
    --use_pretrained_weights True \
    --output_dir out_ct5_cogs_${EPOCHS}_$SLURM_ARRAY_TASK_ID \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --source_prefix "" \
    --train_file data_cogs/train.json \
    --test_file data_cogs/gen.json \
    --gen_conditions_file data_cogs/cogs_gen_conditions.txt \
    --per_device_train_batch_size 32 \
    --per_device_eval_batch_size 32 \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 1024 \
    --max_source_length 1024 \
    --num_train_epochs $EPOCHS \
    --seed $SLURM_ARRAY_TASK_ID \
    --learning_rate 0.0001 \
    --predict_with_generate

echo "Done"
