
from __future__ import print_function

import keras
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from tensorflow.keras.models import Model
from tensorflow.keras.models import load_model
import numpy as np 

import os
import time
import sys
import shutil

# -------------------------------------------------------
sys.path.insert(0, '../../scripts')
import qaz_util as qaz

# # -------------------------------------------------------
# (x_train, y_train),(x_test, y_test) = qaz.load_mnist()

# -------------------------------------------------------
model = load_model('mnist_mlp.h5')
model.summary()

# -------------------------------------------------------
dir = 'weights'
if os.path.exists(dir):
    shutil.rmtree(dir)
os.makedirs(dir)

for i in range(len(model.layers)):
  layer = model.layers[i]
  if layer.name.startswith('dense'):
    qaz.write_dense_weights(layer)
