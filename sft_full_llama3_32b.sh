#!/bin/bash

# Copy/paste this job script into a text file and submit with:
#    sbatch sft_full.sh

#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=128G
#SBATCH --gres=gpu:a100:8
#SBATCH --partition=nova
#SBATCH --job-name="sft_full"
#SBATCH --mail-user=shreyang@iastate.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output="sbatch-logs/sft-qwen32b-full"
#SBATCH --error="sbatch-logs/sft-qwen32b-full"

# Activate conda (adjust path if needed)
source /work/mech-ai/shreyan/miniconda3/etc/profile.d/conda.sh
conda activate /work/mech-ai/shreyan/minconda3/envs/llamafactory

# Change to working dir (quote paths!)
cd "/work/mech-ai-scratch/shreyang/LLaMA-Factory"

# Run your Python script with arguments
export PATH="$CONDA_PREFIX/bin:$PATH"
llamafactory-cli train examples/train_full/qwen2_32b_full_sft.yaml
