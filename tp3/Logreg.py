import theano
import theano.tensor as T
import numpy as np

class LogisticRegression(object):

    def __init__(self, input, n_in, n_out, batch_size):
        #initialisation des parametres
        self.W = theano.shared(
            value=np.ones((n_in, n_out), dtype=theano.config.floatX),
            name='W',
            borrow=True
        )
        self.b = theano.shared(
            value=np.ones((n_out,), dtype=theano.config.floatX),
            name='b',
            borrow=True
        )
        #TODO
        #P(Y=i|x,W,b) = softmax_i(W x + b)
        self.p_y_given_x = T.nnet.softmax(T.dot(input, self.W) + self.b)
        #calcul de l'output
        #y_{pred} = argmax_i P(Y=i|x,W,b)
        self.y_pred = T.argmax(self.p_y_given_x, axis=1)
        self.params = []
        self.input = input

    #calcul de la NLL
    def loss(self, y):
        #TODO
        return -T.mean(T.log(self.p_y_given_x)[T.arange(y.shape[0]), y])

    #calcul de l'erreur
    def errors(self, y):
        #TODO
        return T.mean(T.neq(self.y_pred, y)) #T.mean(((self.y_pred - y)**2))
