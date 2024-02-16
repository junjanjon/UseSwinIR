#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

git submodule update --init

# 事前に venv が必要
python3 -m venv env
. ./env/bin/activate
# インストールメモ
pip install timm
pip install opencv-python
pip freeze > requirements.txt
pip install -r requirements.txt

mkdir -p models
MODEL_PATH=models/realSR_x4.pth
if [ ! -e "${MODEL_PATH}" ]; then
  # real_sr / Super-Resolution 超解像 で 4倍にする学習済みモデル
  curl -L -o "${MODEL_PATH}" https://github.com/JingyunLiang/SwinIR/releases/download/v0.0/003_realSR_BSRGAN_DFOWMFC_s64w8_SwinIR-L_x4_GAN.pth
fi

python SwinIR/main_test_swinir.py \
  --task real_sr \
  --model_path "${MODEL_PATH}" \
  --folder_lq SwinIR/testsets/RealSRSet+5images \
  --scale 4 \
  --large_model

# --model_path: 学習済みモデルのパス / 利用するモデルによって task, scale, large_model を決める
# --folder_lq: 処理前 low-quality 画像のフォルダ
# 結果は ./results 以下に保存される

# usage: main_test_swinir.py [-h] [--task TASK] [--scale SCALE] [--noise NOISE] [--jpeg JPEG] [--training_patch_size TRAINING_PATCH_SIZE] [--large_model] [--model_path MODEL_PATH]
#                            [--folder_lq FOLDER_LQ] [--folder_gt FOLDER_GT] [--tile TILE] [--tile_overlap TILE_OVERLAP]
# options:
#   -h, --help            show this help message and exit
#   --task TASK           classical_sr, lightweight_sr, real_sr, gray_dn, color_dn, jpeg_car, color_jpeg_car
#   --scale SCALE         scale factor: 1, 2, 3, 4, 8
#   --noise NOISE         noise level: 15, 25, 50
#   --jpeg JPEG           scale factor: 10, 20, 30, 40
#   --training_patch_size TRAINING_PATCH_SIZE
#                         patch size used in training SwinIR. Just used to differentiate two different settings in Table 2 of the paper. Images are NOT tested patch by patch.
#   --large_model         use large model, only provided for real image sr
#   --model_path MODEL_PATH
#   --folder_lq FOLDER_LQ
#                         input low-quality test image folder
#   --folder_gt FOLDER_GT
#                         input ground-truth test image folder
#   --tile TILE           Tile size, None for no tile during testing (testing as a whole)
#   --tile_overlap TILE_OVERLAP
#                         Overlapping of different tiles

deactivate
