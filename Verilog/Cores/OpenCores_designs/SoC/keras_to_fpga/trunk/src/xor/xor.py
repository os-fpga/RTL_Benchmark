from keras.models import Model
from tensorflow.keras.models import load_model
import numpy as np 
import os
import struct
import shutil

# -------------------------------------------------------
model = load_model('xor.h5')
model.summary()

# -------------------------------------------------------
x = np.array([[0,0],[0,1],[1,0],[1,1]])
# print(model.predict(x).round())
# print(model.predict(x))
# print('-' * 60)

def float_to_hex(f):
    # return hex(struct.unpack('<I', struct.pack('<f', f))[0])
    return format(struct.unpack('<I', struct.pack('<f', f))[0], 'x')

# -------------------------------------------------------
dir = 'weights'
if os.path.exists(dir):
    shutil.rmtree(dir)
os.makedirs(dir)

for i in range(len(model.layers)):
    layer = model.layers[i]
    print(layer.name)
    w = layer.get_weights()
    # for w in layer.get_weights():
      # print(w.shape)
      # print(w)
      # print('^' * 60)
    print(w[0].shape, w[1].shape)
    print('+' * 60)
    
    for y in range(0, w[0].shape[1]):
      print('-' * 60)
      file_name = dir + '/' + layer.name + '_' + str(y) + '.txt'
      print(file_name)
      with open(file_name, "w") as text_file:
        for x in range(0, w[0].shape[0]):
          # print(float_to_hex(w[0][x][0]))
          print(float_to_hex(w[0][x][y]), file=text_file)
        print(float_to_hex(w[1][y]), file=text_file)
      # close(text_file)
      print('^' * 60)
    
    # print(layer.get_weights())
    
    # a = layer.get_weights()
    # bias = a[1]
    # w = np.concatenate((a[0], bias[np.newaxis,:]), axis=0)
    # # w.astype('float32').tofile(layer.name)
    # print('+' * 60)
    
    # for x in range(0, w.shape[0]):
      # for y in range(0, w.shape[1]):        
        # print(float_to_hex(w[x,y]))
    
    # print('+' * 60)

    
  