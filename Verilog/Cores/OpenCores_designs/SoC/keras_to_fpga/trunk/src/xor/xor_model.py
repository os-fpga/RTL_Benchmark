from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.optimizers import SGD
import numpy as np 

# -------------------------------------------------------
x = np.array([[0,0],[0,1],[1,0],[1,1]])
y = np.array([[0],[1],[1],[0]])

# -------------------------------------------------------
model = Sequential()
model.add(Dense(8, input_dim=x.shape[1], activation='relu'))
model.add(Dense(1, activation='sigmoid'))

model.compile(loss='mean_squared_error',
              optimizer='adam',
              metrics=['binary_accuracy'])

model.fit(x, y, epochs=100000, verbose=0)

print(model.predict(x).round())
print(model.predict(x))

# -------------------------------------------------------
model.save('xor.h5')
model.summary()
