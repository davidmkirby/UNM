# problem 5 
"""
Created on Fri May  4 20:18:16 2018

@author: sapko
"""

import numpy as asp
import matplotlib.pyplot as pl

# solve using Euler method mx'' + dx' + kx = F*sin(ft)
# m is the mass  in kg
# d is the damping constant in Ns/m
# k is the spring constant in N/m
# F is the driving force in N,
# f is the frequency of the driving force 
# x is the position 



T= 20   # final time
N = 100000     # No of step
Dt = T/N      # Stepsize 
Tvec = asp.linspace(0, T, N+1)   


# Array for velocity and position
V = asp.zeros(N+1)
X = asp.zeros(N+1)


k = 1
m = 0.2
V0 = 10
X0 = 0
f0 = 20**0.25
d = 0
F = 0.1
f = 7.0
# intial velocity and time 
V[0] = V0    
X[0] = X0    



#Euler method formula 
# v'(t) = -(k/m)*x(t) - (d/m)*v(t) + (F/m)*cos(f*t)
# x'(t) = v(t)


for tt in range(0, N):
    V[tt+1] = (-k/m)*Dt*X[tt] + V[tt]*(1-Dt*d/m) + (Dt/m)*F*asp.sin(f*tt)
    X[tt+1] = Dt*V[tt] + X[tt]

# Ploting

pl.plot(Tvec, X, 'r-', label='Undamp') # undamped

# setting Damping 50%
d = (f0/50)*.5

#for new Damping 20% 
for aa in range(0, N):
    V[aa+1] = (-k/m)*Dt*X[aa] + V[aa]*(1-(Dt*(d/m))) + (F*Dt/m)*asp.sin(f*aa)
    X[aa+1] = Dt*V[aa] + X[aa]

pl.plot(Tvec, X, 'g-', label = '50% Damping')
pl.plot(Tvec, 0*Tvec, 'k-') 
pl.xlabel('Time')
pl.ylabel('position')    
pl.legend(loc = 'upper right')

