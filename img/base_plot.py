import sys
import os
from pylab import *
#from matplotlib import *

def position_correction(p,away):
  d = {
    'right': [away,0],
    'left': [-away,0],
    'above': [0,away],
    'below': [0,-away],
    'center': [0,0],
  }
  return array(d[p])

def better_arrow(start,direction,length,label='',position='above'):
  start=array(start)
  direction=array(direction)
  n=norm(direction)
  normalized_direction=direction/n
  direction=normalized_direction*length
  head=array([0.15*length,0.4*length])
  arrow(start[0],start[1],direction[0],direction[1],head_width=head[0],head_length=head[1],length_includes_head=True)
  if not text=='':
    #head_end=array([sign(dx),sign(dy)])*head[1]*0.8
    arrow_end=start+direction
    if isinstance(position, str):
      arrow_end=arrow_end+position_correction(position,length*0.5)
    else:
      arrow_end=arrow_end+array(position)
    text(arrow_end[0],arrow_end[1],label)

def savepngfig(name):
  savefig(name+'.png',bbox_inches='tight',dpi=200)

def defaultaxis():
  pass