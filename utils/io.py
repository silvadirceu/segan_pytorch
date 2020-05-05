import numpy as np
import subprocess
from scipy.io import wavfile
import librosa

def getAudio(filename, fs=16000, outFile=None):
    """
    Wrap around scipy to load audio.  Since scipy only
    loads wav files, call avconv through a subprocess to
    convert any non-wav files to a temporary wav file,
    which is removed after loading:
    :param filename: Path to audio file
    :return (XAudio, Fs): Audio in samples, sample rate
    """
    import os
    import random

    prefix = str(random.randint(1, 2000))
    if outFile is None:
        out_filename = 'tmp_' + prefix + '.wav' 
    else:
        out_filename = outFile

    subprocess.call(["avconv", "-i", filename, "-ar", str(fs), out_filename])
    Fs, XAudio = wavfile.read(out_filename)

    if len(XAudio.shape) > 1:
        XAudio = np.mean(XAudio, 1)
    if outFile is None:
        os.remove(out_filename)
    return (XAudio, Fs)

def getAudioLibrosa(filename, sr=8000):
    r"""
    Use librosa to load audio
    :param filename: Path to audio file
    :return (XAudio, Fs): Audio in samples, sample rate
    """
    import librosa
    if filename[-3::] == "wav":
        Fs, XAudio = wavfile.read(filename)
    else:
        try:
            XAudio, Fs = librosa.load(filename, mono=True, sr=sr)
        except:
            XAudio,Fs = getAudio(filename, fs = sr)

    return (XAudio, Fs)