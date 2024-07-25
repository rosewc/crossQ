# crossQ
These Matlab functions and scripts estimate and plot the cross quantilogram matrix.
Function crossQmtx(data,p,lag) returns a matrix of cross quantilogram values, when p is a vector of probabilities in the range 0<p(i)<1. 
The repository Systemic Risk by Tommaso Belluzzo includes functions to compute the scalar cross quantilogram. It requires p to be a scalar in the range 0.01<=p<=0.1.
Function crossQmtxplot() produces a plot of a cross quantilogram matrix. 
Script crossQmtxTest.m demonstrates the use of crossQmtx() and plotcrossQmtx(). See the PDF for more examples of usage.
The function crossQmtx() here, and the functions in Systemic Risk, return the same scalar value, when called with identical arguments.
One weakness of (the current version of) crossQmtx() is that it does not compute confidence intervals.
See the PDF for more details and references.
