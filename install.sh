#!/bin/bash

LIBS_DIR = /home/dirceusilva/development/libs/

pyenv install 3.7.5
pyenv virtualenv 3.7.5 flex
pyenv activate flex

#if problem with torch, try pip install torch===1.4.0 torchvision===0.5.0 -f https://download.pytorch.org/whl/torch_stable.html

cd $LIBS_DIR
git clone https://github.com/silvadirceu/segan_pytorch.git
cd segan_pytorch
pip install req.txt

cd ..
git clone https://github.com/santi-pdp/ahoproc_tools.git
cd ahoproc_tools
python setup.py install

# download the model
cd ckpt_segan+
http://veu.talp.cat/seganp/release_weights/segan+_generator.ckpt

# To install pyannote
cd $LIBS_DIR
git clone https://github.com/pyannote/pyannote-audio.git
cd pyannote-audio
git checkout develop
pip install .
