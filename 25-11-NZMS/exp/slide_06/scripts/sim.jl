"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# Parameters
T = 10.00::Float64                            # Total time
Y = 1.000::Float64                            # Termination condition 

# Paths
ɸ1(t) = Y*(t/T) 
ɸ2(t) = Y*(sinh(t)/sinh(T)) 

# Rate functionals
S1(t) = ((Y^2)/(2*t))*(1 + t + ((t^2)/3))
S2(t) = ((Y^2)/(4*(sinh(t))^2))*(exp(2*t) - 1)
