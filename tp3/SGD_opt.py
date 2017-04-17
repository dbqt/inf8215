import Load_data
import theano.tensor as T
import Logreg
import theano
import numpy as np
import matplotlib.pyplot as plt



def sgd_optimization(learning_rate=0.13, n_epochs=1000,
                           batch_size=300):
    datasets = Load_data.load_data()

    train_set_x, train_set_y = datasets[0]
    valid_set_x, valid_set_y = datasets[1]
    test_set_x, test_set_y = datasets[2]

    # TODO : compute number of minibatches for training, validation and testing from the size of a minibatch
    n_train_batches = train_set_x.get_value(borrow=True).shape[0]
    n_valid_batches = valid_set_x.get_value(borrow=True).shape[0]
    n_test_batches = test_set_x.get_value(borrow=True).shape[0]

    index = T.lscalar()
    x = T.matrix('x')
    y = T.ivector('y')

    #TODO : 1.3.1
    logreg = Logreg.LogisticRegression(input=x, n_in=32 * 32, n_out=24, batch_size=batch_size)
    cost = logreg.loss(y)

    test_model = theano.function(
        #TODO
        inputs=[index],
        outputs=logreg.errors(y),
        givens={
            x: test_set_x[index * batch_size: (index + 1) * batch_size],
            y: test_set_y[index * batch_size: (index + 1) * batch_size],
        }
    )
    validate_model = theano.function(
        #TODO
        inputs=[index],
        outputs=logreg.errors(y),
        givens={
            x: valid_set_x[index * batch_size: (index + 1) * batch_size],
            y: valid_set_y[index * batch_size: (index + 1) * batch_size],
        }
    )

    g_W = g_W = T.grad(cost=cost, wrt=logreg.W)#TODO
    g_b = T.grad(cost=cost, wrt=logreg.b)#TODO
    updates = [(logreg.W, logreg.W - learning_rate * g_W),
               (logreg.b, logreg.b - learning_rate * g_b)]
    train_model = theano.function(
        #TODO
        inputs=[index],
        outputs=cost,
        updates=updates,
        givens={
            x: train_set_x[index * batch_size: (index + 1) * batch_size],
            y: train_set_y[index * batch_size: (index + 1) * batch_size],
        }
    )

    best_validation_loss = np.inf
    best_iter = 0
    test_score = 0.
    epoch = 0
    done_looping = False
    err = 1
    thr = 0.001
    ndiv = 0
    valErr = []
    testErr = []
    testind = []

    #TODO : 1.3.2
    while epoch < n_epochs:
        epoch = epoch + 1
        for minibatch_index in range(n_train_batches):
            # TODO train model
            train_model(minibatch_index)

        # TODO : valid model, print error
        validation_losses = [validate_model(i) for i in range(n_valid_batches)]
        this_validation_loss = np.mean(validation_losses)
        print('epoch %i, validation error %f %%' %
              (epoch, this_validation_loss * 100.)
              )
        # valErr.append(this_validation_loss)
        if this_validation_loss < best_validation_loss:
            best_validation_loss = this_validation_loss
            # test it on the test set
            test_losses = [test_model(i) for i in range(n_test_batches)]
            test_score = np.mean(test_losses)

            print(('     epoch %i, test error of best model %f %%') %
                  (epoch, test_score * 100.))
            testErr.append(test_score)
            testind.append(epoch)
        if (err - this_validation_loss < thr):
            if ndiv > 2:
                done_looping = True
                break
            else:
                ndiv = ndiv + 1
                thr = thr / 10.0
                learning_rate = learning_rate / 5.0
        err = (10 * err + this_validation_loss) / 11.0

        # TODO : test model, print result
        testErr.append(test_score)
        testind.append(epoch)
        print(('Optimization complete. Best validation score of %f %% '
               ' with test performance %f %%') %
              (best_validation_loss * 100., test_score * 100.))

    #TODO : plot with matplotlib the train NLL and the error on test for each minibatch/epoch
    plt.plot(range(0, len(valErr)), valErr)
    plt.plot(testind, testErr)
    plt.show()

if __name__ == '__main__':
    #n_epochs=30;batch_size=0;learning_rate=0
    sgd_optimization(n_epochs=30, learning_rate=0.13, batch_size=300)