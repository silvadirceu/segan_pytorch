:: INPUT
:: run_segan+_clean.sh <NOISE_DATA_PATH> <SAVE_PATH>
:: NOISE_DATA_PATH and SAVE_PATH are  optionals
:: Default: NOISE_DATA_PATH = "data/"
::          SAVE_PATH = "synth_segan+"

set CKPT_PATH=ckpt_segan+

:: please specify the path to your G model checkpoint
:: as in weights_G-EOE_<iter>.ckpt
set G_PRETRAINED_CKPT=segan+_generator.ckpt

:: please specify the path to your folder containing
:: noisy test files, each wav in there will be processed
set NOISY_PATH=.\\data\\
IF NOT EXIST %NOISY_PATH% (
  set NOISY_PATH=%1%
)

:: please specify the output folder where cleaned files
:: will be saved
set SAVE_PATH=.\\synth_segan+\\
IF NOT EXIST %SAVE_PATH% (
  set SAVE_PATH=%2%
)

echo "INPUT NOISY PATH: %NOISY_PATH%"
echo "SAVE PATH: %SAVE_PATH%"
mkdir %SAVE_PATH%

python -u clean.py --g_pretrained_ckpt %CKPT_PATH%\%G_PRETRAINED_CKPT% --test_files %NOISY_PATH% --cfg_file %CKPT_PATH%\train.opts --synthesis_path %SAVE_PATH% --soundfile
