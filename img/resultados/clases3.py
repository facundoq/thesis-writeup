import sys
import os
sys.path.append(os.path.realpath('../'))
from base_plot import *
from pylab import *
from math import exp,sqrt
import numpy as np
import matplotlib as mp



def graph_svml():
  csvfile=open('ff-lnhg.csv', 'rb')
  rows= csv.reader(csvfile, delimiter=',')

  topology=221
  samples=30
  sd=2
  w=array([ -0.5,-2,-0.5,1 ])
  away=array([ [0,-2],[0,-2],[0,-3],[1,-3] ])
  x=np.arange(-10.0,10.0,0.1)
  for sp in xrange(4):
    subplot(topology+sp,aspect='equal')
    default_axes(10)
    plot(x,x*w[sp])
    arrow_size=4
    side = 1 if sp<2 else -1;
    direction= [w[sp]*side,-1*side]
    better_arrow([0,0],direction,arrow_size,label='$\mathbf{w}$',position=away[sp])
  savepngfig('perceptron_entrenamiento')

if __name__=='__main__':
  figure(figsize=(20,10))
  #graph_clases3()
  #savepngfig('clases3')
  graph_perceptron_entrenamiento()

  show()

