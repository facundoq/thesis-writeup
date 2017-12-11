import sys
import os
sys.path.append(os.path.realpath('../'))
from base_plot import *
from pylab import *
from math import exp,sqrt
import numpy as np
import matplotlib as mp

def gaussian2d(ux,uy,sx,sy,samples):
  cov = array([[sx,0],[0,sy]])
  x,y = np.random.multivariate_normal([ux,uy],cov ,size=samples).T
  return(x,y)

def gaussian2d_isotropic(ux,uy,scale,samples):
  return gaussian2d(ux,uy,scale,scale,samples)

def gaussian2d_unit(ux,uy,samples):
  return gaussian2d_isotropic(ux,uy,1,samples)

def default_axes(r=10):
  ylim([-r,r])
  xlim([-r,r])

def graph_clases3():
  (x,y)=gaussian2d_unit(0,0,20)
  scatter(x,y)


def graph_perceptron_entrenamiento():
  topology=141
  samples=30
  sd=2
  (x1,y1)=gaussian2d_isotropic(-3,4,sd,samples)
  (x2,y2)=gaussian2d_isotropic(3,-4,sd,samples)
  w=array([ -0.5,-2,-0.5,1 ])
  away=array([ [0,-2],[0,-2],[0,-3],[1,-3] ])
  x=np.arange(-10.0,10.0,0.1)
  for sp in xrange(4):
    subplot(topology+sp,aspect='equal')
    default_axes(10)
    scatter(x1,y1,marker='+')
    scatter(x2,y2,marker='_')
    plot(x,x*w[sp])
    arrow_size=4
    side = 1 if sp<2 else -1;
    direction= [w[sp]*side,-1*side]
    better_arrow([0,0],direction,arrow_size,label='$\mathbf{w}$',position=away[sp])
if __name__=='__main__':
  figure(figsize=(20,10))
  #graph_clases3()
  #savepngfig('clases3')
  graph_perceptron_entrenamiento()
  savepngfig('perceptron_entrenamiento')

  show()

