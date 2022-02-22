# Design Description

The CORDIC algorithm is an iterative algorithm to evaluate many mathematical functions, such as trigonometrically functions, hyperbolic functions and planar rotations.

As the name suggests the CORDIC algorithm was developed for rotating coordinates, a piece of hardware for doing real-time navigational computations in the 1950's. The CORDIC uses a sequence like successive approximation to reach its results. The nice part is it does this by adding/subtracting and shifting only. Suppose we want to rotate a point(X,Y) by an angle(Z). The coordinates for the new point(Xnew, Ynew) are:

    Xnew = X * cos(Z) - Y * sin(Z) Ynew = Y * cos(Z) + X * sin(Z) 

Or rewritten:

    Xnew / cos(Z) = X - Y * tan(Z) Ynew / cos(Z) = Y + X * tan(Z) 

It is possible to break the angle into small pieces, such that the tangents of these pieces are always a power of 2. This results in the following equations:

    X(n+1) = P(n) * ( X(n) - Y(n) / 2^n) Y(n+1) = P(n) * ( Y(n) + X(n) / 2^n) Z(n) = atan(1/2^n) 

The atan(1/2^n) has to be pre-computed, because the algorithm uses it to approximate the angle. The P(n) factor can be eliminated from the equations by pre-computing its final result. If we multiply all P(n)'s together we get the aggregate constant.

    P = cos(atan(1/2^0)) * cos(atan(1/2^1)) * cos(atan(1/2^2))....cos(atan(1/2^n)) 

This is a constant which reaches 0.607... Depending on the number of iterations and the number of bits used. The final equations look like this:

    Xnew = 0.607... * sum( X(n) - Y(n) / 2^n) Ynew = 0.607... * sum( Y(n) + X(n) / 2^n) 

Now it is clear how we can simply implement this algorithm, it only uses shifts and adds/subs. Or in a program-like style:

    For i=0 to n-1
        If (Z(n) >= 0) then
            X(n + 1) := X(n) – (Yn/2^n); Y(n + 1) := Y(n) + (Xn/2^n); Z(n + 1) := Z(n) – atan(1/2^i); Else
            X(n + 1) := X(n) + (Yn/2^n); Y(n + 1) := Y(n) – (Xn/2^n); Z(n + 1) := Z(n) + atan(1/2^i); End if; End for; 

Where 'n' represents the number of iterations. 

# Directory structure

    ├── doc               # Documentation
    └── rtl               # RTL Sources
        ├── polar2rect
        └── rect2polar


# Utilization Report
Synthesized on Artix-7 device using vivado.

### polar2rect
|Resource| No.|
|:---:|:---:|
|LUT|705|
|FF|689|
|DSP|0|
|BRAM|0|
|IO|50|

### rect2polar
|Resource| No.|
|:---:|:---:|
|LUT|949|
|FF|1001|
|DSP|0|
|BRAM|0|
|IO|74|

# Testbench
Unavailable

# Documentation
Available
