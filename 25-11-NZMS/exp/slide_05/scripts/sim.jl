"""
    Simulation script

Storage of the definitions of the system alongside all the settings of the problem.
"""

# System parameters
ϑ = 1.000::Float64                            # Variance parameter 
ε = 0.000::Float64                            # Timescale separation
σ = 0.040::Float64                            # Noise level (additive)
D = (σ^2)/2.0                                 # Diffusion level (additive) 
T = 10.00::Float64                            # Total time
Y = 0.100::Float64                            # Termination condition 

# Dynamical system  
f(x, μ) = -μ*x                                # Drift
Λ(t) = ε                                      # Shift/Ramp
η(x) = σ                                      # Diffusion

# Initial condition 
equilibria = get_equilibria(f, ϑ, domain=[-10,10])
x0 = [equilibria.stable[1], ϑ]

# Simulation parameters
dt = 1e-3                                     # Timestep
Ne = 1e4                                      # Number of particles in the ensemble

# Paths
ɸ1(t) = Y*(t/T) 
ɸ2(t) = Y*(sinh(t)/sinh(T)) 

# Rate functionals
S1(t) = ((Y^2)/(2*t))*(1 + t + ((t^2)/3))
S2(t) = ((Y^2)/(4*(sinh(t))^2))*(exp(2*t) - 1)
