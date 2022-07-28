
from __future__ import print_function

import keras
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from keras.models import Model
from tensorflow.keras.models import load_model
import numpy as np 
import os
import struct
import shutil
import qaz_util as qaz

# the data, split between train and test sets
(x_train, y_train), (x_test, y_test) = mnist.load_data()

x_train = x_train.reshape(60000, 784)
x_test = x_test.reshape(10000, 784)
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255
print(x_train.shape[0], 'train samples')
print(x_test.shape[0], 'test samples')

# -------------------------------------------------------

# print(x_test[0:3])
print(y_test[0:4])

file_name = 'x_test' + '_' + str(0) + '.raw'
print(file_name)

# with open(file_name, "bw") as fh:
  # x_test[0].tofile(fh)

# print(x_test[0].shape)
# qaz.show_the_image(x_test[0].reshape((28, 28))) 

a = np.arange(28*28).reshape((28, 28))
a = a.astype('float32')
qaz.show_the_image(a) 

with open(file_name, "bw") as fh:
  a.flatten().tofile(fh)

