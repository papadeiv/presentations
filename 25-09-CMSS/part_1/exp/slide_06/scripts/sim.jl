"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# Parameter values 
μ = [0.0350627949, 0.0]

# Dynamical system  
f(x, μ) =  x*(1 - x)*((3/2)*x - (1/2)) + μ                  # Vector field
V(x, μ) =  (3/8)*(x^4) - (2/3)*(x^3) + (1/4)*(x^2) - μ*x    # Scalar potential 
