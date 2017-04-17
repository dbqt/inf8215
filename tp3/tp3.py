import NLP
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

data = np.load('dataY.npy')
#print(data)

NLP.test_mlp(0.13, 1, 30, 10, 0)


#cmap = matplotlib.cm.Greys
#for i in data:
#    plt.imshow(i.reshape((32, 32)), cmap=cmap)

