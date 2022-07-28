
from __future__ import print_function

import keras
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout

import os
import struct
import shutil

num_classes = 10

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

from keras.models import Model
from tensorflow.keras.models import load_model
import numpy as np 

# -------------------------------------------------------
model = load_model('mnist_mlp.h5')
model.layers[-1].activation=None

temp_weights = [layer.get_weights() for layer in model.layers]
for i in range(len(temp_weights)):
    model.layers[i].set_weights(temp_weights[i])

# -------------------------------------------------------
model = Sequential()
model.add(Dense(128, activation='relu', input_shape=(784,)))
model.add(Dropout(0.1))
model.add(Dense(64, activation='relu'))
model.add(Dropout(0.1))
model.add(Dense(32, activation='relu'))
# model.add(Dropout(0.05))
model.add(Dense(16, activation='relu'))
# model.add(Dropout(0.2))
model.add(Dense(32, activation='relu'))
# model.add(Dropout(0.05))
model.add(Dense(64, activation='relu'))
model.add(Dropout(0.1))
model.add(Dense(num_classes)) 

model.summary()

model.compile(loss='sparse_categorical_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])
              
# -------------------------------------------------------
for i in range(len(temp_weights)):
    model.layers[i].set_weights(temp_weights[i])

# -------------------------------------------------------
print(x_test.shape)
print(x_test[:4,:].shape)

print(model.predict(x_test[:4,:]))

