#!/bin/bash

#SBATCH --account=cds
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20GB
#SBATCH --time=48:00:00
#SBATCH --job-name=marian_scan
#SBATCH --output=marian_scan_%A_%a.out
#SBATCH --array=0-9

module purge
module load cuda/11.1.74

SPLIT=right  # add_jump, add_turn_left, around_right, jump_around_right, length, opposite_right, right
SRC_LANG=de  # de, es, fi, hu, fi
TGT_LANG=fr  # fr, it, nl, fi, cs
EPOCHS=13

python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark SCAN \
    --use_pretrained_weights True \
    --model_name_or_path Helsinki-NLP/opus-mt-$SRC_LANG-$TGT_LANG \
    --source_lang $SRC_LANG \
    --target_lang $TGT_LANG \
    --output_dir out_marian_${SRC_LANG}_${TGT_LANG}_${SPLIT}_${EPOCHS}_$SLURM_ARRAY_TASK_ID \
    --train_file data_scan/$SPLIT/train.json \
    --test_file data_scan/$SPLIT/test.json \
    --do_train \
    --do_predict \
    --per_device_train_batch_size 32 \
    --per_device_eval_batch_size 32 \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 512 \
    --max_source_length 512 \
    --num_train_epochs $EPOCHS \
    --seed $SLURM_ARRAY_TASK_ID \
    --predict_with_generate

echo "Done"
