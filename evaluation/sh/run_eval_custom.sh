# Evaluate Qwen2.5-Math-Instruct
PROMPT_TYPE="qwen25-math-cot"
DATASET_NAME="math"  # You can modify this as per your requirement

# List of models to evaluate (add more models as needed)
MODEL_NAME_LIST=(
    # "Qwen/Qwen2.5-14B-Instruct"
    "/mnt/longcontext/models/siyuan/rl_ckpts/qwen25_14B_mi300_2node_16k_2k_math_filtered_dis_mathqa_256bsz_20ksamples_grpo_subem_end-step85"
    "/mnt/longcontext/models/siyuan/llama3/DeepSeek-R1-Distill-Qwen-7B"
    "/mnt/longcontext/models/siyuan/llama3/DeepSeek-R1-Distill-Qwen-32B"
    "/mnt/longcontext/models/siyuan/llama3/QwenLong-L1-32B"
)
export TEMPERATURE=0.6

# Set the CUDA devices for multi-GPU usage
export CUDA_VISIBLE_DEVICES="0,1,2,3"

# Get the current timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Loop through each model in the list and run the evaluation script
for MODEL_NAME_OR_PATH in "${MODEL_NAME_LIST[@]}"; do
    # Get the model basename (the last part of the model path)
    MODEL_NAME_LAST_PART=$(basename "$MODEL_NAME_OR_PATH")
    
    # Create the directory structure if it doesn't exist
    LOG_DIR="logs/${MODEL_NAME_LAST_PART}/${DATASET_NAME}"
    mkdir -p "$LOG_DIR"
    
    # Log file path
    LOG_FILE="${LOG_DIR}/${DATASET_NAME}-${TIMESTAMP}.log"
    
    echo ">>> Evaluating model: ${MODEL_NAME_OR_PATH}"  # Print which model is being evaluated
    
    # Run the evaluation and capture the output, logging it to a specific file with tee
    bash sh/custom_eval.sh "$PROMPT_TYPE" "$MODEL_NAME_OR_PATH" 2>&1 | tee -a "$LOG_FILE"
done

keep-gpu