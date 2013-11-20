#-------------------------------------------------------------------------------
# Name:        module1
# Purpose:
#
# Author:      facuq
#
# Created:     16/11/2013
# Copyright:   (c) facuq 2013
# Licence:     <your licence>
#-------------------------------------------------------------------------------
from sympy import *
from sympy.plotting import plot3d
def main2():
  x,y,c,f= symbols('x y c f')
  a1=4
  a2=3
  c= x*4/3
  plot(c**3)

def main():
  x,y,c,f,rd= symbols('x y c f rd')
  c= x*4+y*3
  f= c**2
  radius=3
  r=5
  p=plot3d(f)


if __name__ == '__main__':
  main2()
