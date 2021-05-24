#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=180GB
#SBATCH --time=48:00:00
#SBATCH --array=0
#SBATCH --job-name=marian_fics_cogs
#SBATCH --output=marian_fics_cogs_%A_%a.out

module purge
module load cuda/11.1.74

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --model_name_or_path Helsinki-NLP/opus-mt-fi-cs \
    --use_pretrained_weights True \
    --output_dir out_marian_fics_cogs \
    --source_lang fi \
    --target_lang cs \
    --do_train \
    --do_predict \
    --train_file data_cogs/train.json \
    --test_file data_cogs/gen.json \
    --gen_conditions_file data_cogs/cogs_gen_conditions.txt \
    --per_device_train_batch_size 64 \
    --per_device_eval_batch_size 64 \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 512 \
    --max_source_length 512 \
    --num_train_epochs 30 \
    --predict_with_generate

echo "Done"
