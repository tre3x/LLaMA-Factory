#!/bin/bash

# Copy/paste this job script into a text file and submit with:
#    sbatch inference_.sh

#SBATCH --time=140:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --mem=128G
#SBATCH --gres=gpu:a100:1
#SBATCH --partition=nova
#SBATCH --job-name="inference_"
#SBATCH --mail-user=shreyang@iastate.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output="sbatch-logs/inference_"
#SBATCH --error="sbatch-logs/inference_"

# Activate conda (adjust path if needed)
source /work/mech-ai/shreyan/miniconda3/etc/profile.d/conda.sh
conda activate /work/mech-ai/shreyan/minconda3/envs/llamafactory

# Change to working dir (quote paths!)
cd "/work/mech-ai-scratch/shreyang/LLaMA-Factory"


export PATH="$CONDA_PREFIX/bin:$PATH"
#Llama3-8b Full SFT
python raw_hf_sft.py \
  --config_yaml "/work/mech-ai-scratch/shreyang/LLaMA-Factory/examples/inference/llama3_8b_full_sft.yaml" \
  --input_file "/work/mech-ai-scratch/shreyang/Agentic Ag/query_generation/benchmark/final_annotation_questions_100.json" \
  --output_file "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/response_llama3_8b_full_sft_gbm.json" \
  --partial_file_path "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/partial/llama3_8b_full_sft.json" \
  --from_benchmark 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/format.py" --input "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/response_llama3_8b_full_sft_gbm.json"\
                 --output "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/formatted/llama3_8b_full_sft.json" 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/merge_metadata.py" --input "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/formatted/llama3_8b_full_sft.json"\
                         --output "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/with_metadata/llama3_8b_full_sft.json" 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/create_benchmark_response.py" --benchmark_json "/work/mech-ai-scratch/shreyang/Agentic Ag/query_generation/benchmark/final_annotation_questions_100.json"\
                                    --larger_json "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/with_metadata/llama3_8b_full_sft.json"\
                                    --output_json "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/benchmark/llama3_8b_full_sft.json" 

#Mistral-7b Full SFT
python raw_hf_sft.py \
  --config_yaml "/work/mech-ai-scratch/shreyang/LLaMA-Factory/examples/inference/mistral_7b_full_sft.yaml" \
  --input_file "/work/mech-ai-scratch/shreyang/Agentic Ag/query_generation/benchmark/final_annotation_questions_100.json" \
  --output_file "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/response_mistral_7b_full_sft_gbm.json" \
  --partial_file_path "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/partial/mistral_7b_full_sft_gbm.json" \
  --from_benchmark 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/format.py" --input "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/response_mistral_7b_full_sft_gbm.json"\
                 --output "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/formatted/mistral_7b_full_sft.json" 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/merge_metadata.py" --input "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/formatted/mistral_7b_full_sft.json"\
                         --output "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/with_metadata/mistral_7b_full_sft.json" 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/create_benchmark_response.py" --benchmark_json "/work/mech-ai-scratch/shreyang/Agentic Ag/query_generation/benchmark/final_annotation_questions_100.json"\
                                    --larger_json "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/with_metadata/mistral_7b_full_sft.json"\
                                    --output_json "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/benchmark/mistral_7b_full_sft.json" 


#Phi3.8b Full SFT
python raw_hf_sft.py \
  --config_yaml "/work/mech-ai-scratch/shreyang/LLaMA-Factory/examples/inference/phi_3_8b_full_sft.yaml" \
  --input_file "/work/mech-ai-scratch/shreyang/Agentic Ag/query_generation/benchmark/final_annotation_questions_100.json" \
  --output_file "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/response_phi3_3b_full_sft_gbm.json" \
  --partial_file_path "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/partial/phi3_3b_full_sft.json" \
  --from_benchmark 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/format.py" --input "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/raw/response_phi3_3b_full_sft_gbm.json"\
                 --output "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/formatted/phi3_3b_full_sft.json" 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/merge_metadata.py" --input "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/formatted/phi3_3b_full_sft.json"\
                         --output "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/with_metadata/phi3_3b_full_sft.json" 

python "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/create_benchmark_response.py" --benchmark_json "/work/mech-ai-scratch/shreyang/Agentic Ag/query_generation/benchmark/final_annotation_questions_100.json"\
                                    --larger_json "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/with_metadata/phi3_3b_full_sft.json"\
                                    --output_json "/work/mech-ai-scratch/shreyang/Agentic Ag/response_generation/response/benchmark/phi3_3b_full_sft.json" 