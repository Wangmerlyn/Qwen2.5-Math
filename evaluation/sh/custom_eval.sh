set -x

PROMPT_TYPE=${1:-qwen25-math-cot}
MODEL_NAME_OR_PATH=${2:-Qwen/Qwen2.5-7B-Math-Instruct}
DATA_NAME=${3:-math}

# Optional environment overrides
TEMPERATURE=${TEMPERATURE:-0}
TOP_P=${TOP_P:-1}

# basename
MODEL_NAME_LAST_PART=$(basename "$MODEL_NAME_OR_PATH")
OUTPUT_DIR=${MODEL_NAME_LAST_PART}/math_eval

SPLIT="test"
NUM_TEST_SAMPLE=-1

# === Print settings ===
echo "================= Settings ================="
echo "PROMPT_TYPE         = ${PROMPT_TYPE}"
echo "MODEL_NAME_OR_PATH  = ${MODEL_NAME_OR_PATH}"
echo "MODEL_NAME_LAST_PART= ${MODEL_NAME_LAST_PART}"
echo "DATA_NAME           = ${DATA_NAME}"
echo "OUTPUT_DIR          = ${OUTPUT_DIR}"
echo "SPLIT               = ${SPLIT}"
echo "NUM_TEST_SAMPLE     = ${NUM_TEST_SAMPLE}"
echo "TEMPERATURE         = ${TEMPERATURE}"
echo "TOP_P               = ${TOP_P}"
echo "===================================="

# English open datasets
TOKENIZERS_PARALLELISM=false \
python3 -u math_eval.py \
    --model_name_or_path ${MODEL_NAME_OR_PATH} \
    --data_name ${DATA_NAME} \
    --output_dir ${OUTPUT_DIR} \
    --split ${SPLIT} \
    --prompt_type ${PROMPT_TYPE} \
    --num_test_sample ${NUM_TEST_SAMPLE} \
    --seed 0 \
    --temperature ${TEMPERATURE} \
    --n_sampling 1 \
    --top_p ${TOP_P} \
    --start 0 \
    --end -1 \
    --use_vllm \
    --save_outputs \
    --overwrite

bash sh/upload_results.sh