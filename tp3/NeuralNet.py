import HiddenLayer
import Logreg
import numpy as np

class NN(object):
    def __init__(self, input, n_in, n_hidden, n_out, batch_size):
        self.hidden = HiddenLayer.HiddenLayer(input, n_in, n_hidden)
        self.logreg = Logreg.LogisticRegression(self.hidden.output, n_hidden, n_out, batch_size)

        self.input = input
        self.L2 = (self.hidden.W ** 2).sum() + (self.logreg.W ** 2).sum()
        self.params = [self.hidden.W, self.hidden.b, self.logreg.W, self.logreg.b]
        self.NLL = self.logreg.loss