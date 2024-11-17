#! bash

set -e

DIRECTORY="$PWD"/tmp

echo "$DIRECTORY"
if [ ! -d "$DIRECTORY" ]; then
  mkdir tmp
fi

pushd tmp


MLX_EX="$PWD"/mlx-examples
if [ ! -d "$MLX_EX" ]; then
  git clone https://github.com/ml-explore/mlx-examples.git
fi

pushd mlx-examples
git checkout bd6d910ca3744d75bf704e6e7039f97f71014bd5

python3 llms/llama/convert.py --torch-path ../../../pytorch_models/TinyLlama-1.1B-Chat-v1.0 --model-name tiny_llama --dtype float32 --mlx-path ../../tiny_llama
python3 whisper/convert.py --torch-name-or-path tiny --dtype float32 --mlx-path ../../whisper_tiny_fp32

popd
popd
rm -rf tmp