#
import numpy as np
import tensorflow as tf
from tensorflow.keras.datasets import cifar10
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import shutil
import struct
import os

# ---------------------------------------------------------------
def plot_history(history, name):
  # summarize history for accuracy
  plt.plot(history.history['sparse_top_k_categorical_accuracy'])
  plt.title('model accuracy')
  plt.ylabel('accuracy')
  plt.xlabel('epoch')
  plt.savefig(str(name) + '_model_accuracy.png')
  plt.close()

  # summarize history for loss
  plt.plot(history.history['loss'])
  plt.title('model loss')
  plt.ylabel('loss')
  plt.xlabel('epoch')
  plt.savefig(str(name) + '_model_loss.png')
  plt.close()

# ---------------------------------------------------------------
def show_the_image(image, title=None):
  # plt.imshow(image, interpolation='bilinear')
  plt.imshow(image, cmap=plt.cm.gray)
  if title is not None:
    plt.title(title)
  plt.show()

# ---------------------------------------------------------------
def save_the_image(image, filename, title=None):
  # plt.imshow(image, interpolation='bilinear')
  plt.imshow(image)
  if title is not None:
    plt.title(title)
  plt.savefig(filename)
  plt.close()

# -------------------------------------------------------
def grid_plot(im):
  nrow = im.shape[0]
  ncol = im.shape[1]
  fig = plt.figure(figsize=(ncol+1, nrow+1))
  gs = gridspec.GridSpec(nrow, ncol,
           wspace=0.02, hspace=0.02,
           top=1.-0.5/(nrow+1), bottom=0.5/(nrow+1),
           left=0.5/(ncol+1), right=1-0.5/(ncol+1))

  for i in range(nrow):
    for j in range(ncol):
      ax= plt.subplot(gs[i,j])
      ax.imshow(im[i][j], cmap=plt.get_cmap('gray'))
      plt.axis('off')

  plt.show()

# -------------------------------------------------------
def load_mnist():
  mnist = tf.keras.datasets.mnist  # mnist is a dataset of 28x28 images of handwritten digits and their labels

  # input image dimensions
  img_rows, img_cols = 28, 28

  # the data, split between train and test sets
  (x_train, y_train), (x_test, y_test) = mnist.load_data()

  x_train = x_train.reshape(x_train.shape[0], img_rows, img_cols, 1)
  x_test = x_test.reshape(x_test.shape[0], img_rows, img_cols, 1)

  x_train = x_train.astype('float32')
  x_test = x_test.astype('float32')
  x_train /= 255
  x_test /= 255

  print('x_train shape:', x_train.shape)
  print(x_train.shape[0], 'train samples')
  print(x_test.shape[0], 'test samples')

  return (x_train, y_train),(x_test, y_test)

# -------------------------------------------------------
def load_cifar10():

  # The data, split between train and test sets:
  (x_train, y_train), (x_test, y_test) = cifar10.load_data()
  # print('x_train shape:', x_train.shape)
  # print(x_train.shape[0], 'train samples')
  # print(x_test.shape[0], 'test samples')

  return (x_train, y_train),(x_test, y_test)

# -------------------------------------------------------
def float_to_hex(f):
    return format(struct.unpack('<I', struct.pack('<f', f))[0], 'x')

# -------------------------------------------------------
def save_float_to_raw(a, name, index=None):
  if index:
    file_name = name + '_' + str(index) + '.raw'
  else:
    file_name = name + '.raw'
  print('save_float_to_raw() |', file_name)
  a = a.astype('float32')
  with open(file_name, "bw") as fh:
    a.flatten().tofile(fh)

# -------------------------------------------------------
def write_conv2d_kernel(layer, dir='weights'):
  w = layer.get_weights()
  for i in range(layer.input_shape[3]):
    for o in range(layer.output_shape[3]):
      file_name = dir + '/' + layer.name + '-' + str(i)  + '_' + str(o) + '.txt'
      print(file_name)
      with open(file_name, "w") as text_file:
        for y in range(0, 3):
          for x in range(0, 3):
            print(float_to_hex(w[0][x,y,i,o]), file=text_file)

# -------------------------------------------------------
def write_dense_weights(layer, dir='weights'):
  w = layer.get_weights()
  for y in range(0, w[0].shape[1]):
    file_name = dir + '/' + layer.name + '_' + str(y) + '.txt'
    print(file_name)
    with open(file_name, "w") as text_file:
      for x in range(0, w[0].shape[0]):
        print(float_to_hex(w[0][x][y]), file=text_file)
      print(float_to_hex(w[1][y]), file=text_file)


