#
from __future__ import print_function

import keras
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
import sys

# -------------------------------------------------------
sys.path.insert(0, '../../scripts')
import qaz_util as qaz

# -------------------------------------------------------
batch_size = 128
num_classes = 10
epochs = 20

# -------------------------------------------------------
(x_train, y_train),(x_test, y_test) = qaz.load_mnist()
x_train = x_train.reshape(60000, 784)
x_test = x_test.reshape(10000, 784)

# -------------------------------------------------------
# # convert class vectors to binary class matrices
# y_train = keras.utils.to_categorical(y_train, num_classes)
# y_test = keras.utils.to_categorical(y_test, num_classes)

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
model.add(Dense(num_classes, activation='softmax'))

# -------------------------------------------------------
model.summary()

model.compile(loss='sparse_categorical_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])

history = model.fit(x_train, y_train,
                    batch_size=batch_size,
                    epochs=epochs,
                    verbose=1,
                    validation_data=(x_test, y_test))
score = model.evaluate(x_test, y_test, verbose=0)
print('Test loss:', score[0])
print('Test accuracy:', score[1])

# -------------------------------------------------------
model.save('mnist_mlp.h5')
model.summary()

