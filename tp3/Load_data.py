import theano
import numpy as np
import theano.tensor as T

def load_data():
    #TODO : load the data set and so it can be easily used
    #use np.load to load the data
    #dataset = ''

    dataX = np.load('dataX.npy')
    dataY = np.load('dataY.npy')
    n = len(dataY)

    random_perm = np.random.permutation(n)
    dataX = dataX[random_perm]
    dataY = dataY[random_perm]

    train_set = (dataX[:int(n*0.7)], dataY[:int(n*0.7)])
    test_set = (dataX[int(n*0.7):int(n*0.85)], dataY[int(n*0.7):int(n*0.85)])
    valid_set = (dataX[int(n*0.85):], dataY[int(n*0.85):])

    print('... loading data')

    def shared_dataset(data_xy, borrow=True):
        data_x, data_y = data_xy
        shared_x = theano.shared(np.asarray(data_x, dtype=theano.config.floatX), borrow=borrow)
        shared_y = theano.shared(np.asarray(data_y, dtype=theano.config.floatX), borrow=borrow)
        return shared_x, T.cast(shared_y, 'int32')

    test_set_x, test_set_y = shared_dataset(test_set)
    valid_set_x, valid_set_y = shared_dataset(valid_set)
    train_set_x, train_set_y = shared_dataset(train_set)

    rval = [(train_set_x, train_set_y), (valid_set_x, valid_set_y),
            (test_set_x, test_set_y)]
    return rval