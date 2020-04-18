#!/bin/bash

# INPUT
# run_segan+_clean.sh <NOISE_DATA_PATH> <SAVE_PATH>
# NOISE_DATA_PATH and SAVE_PATH are  optionals
# Default: NOISE_DATA_PATH = "data/"
#         SAVE_PATH = "synth_segan+"

# guia file containing pointers to files to clean up
#if [ $# -lt 1 ]; then
#    echo 'ERROR: at least wavname must be provided!'
#    echo "Usage: $0 <guia_file> [optional:save_path]"
#    echo "If no save_path is specified, clean file is saved in current dir"
#    exit 1
#fi

CKPT_PATH="ckpt_segan+"

# please specify the path to your G model checkpoint
# as in weights_G-EOE_<iter>.ckpt
G_PRETRAINED_CKPT="segan+_generator.ckpt"

# please specify the path to your folder containing
# noisy test files, each wav in there will be processed
NOISY_PATH="data/"
if [ $# -gt 0 ]; then
  NOISY_PATH="$1"
fi

# please specify the output folder where cleaned files
# will be saved
SAVE_PATH="synth_segan+"
if [ $# -gt 1 ]; then
  SAVE_PATH="$2"
fi

echo "INPUT NOISY PATH: $NOISY_PATH"
echo "SAVE PATH: $SAVE_PATH"
mkdir -p $SAVE_PATH

python -u clean.py --g_pretrained_ckpt $CKPT_PATH/$G_PRETRAINED_CKPT \
	--test_files $NOISY_PATH --cfg_file $CKPT_PATH/train.opts \
  --synthesis_path $SAVE_PATH --soundfile
