"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# System parameters
μ = collect(range(-1.0, stop=-0.1, step=0.1)) # Bifurcation parameter value
ε = 0.0                                       # Timescale separation
σ = 0.100                                     # Noise level (additive)
D = (σ^2)/2.0                                 # Diffusion level (additive) 

# Dynamical system  
f(x, μ) = -μ - x^2                            # Drift
Λ(t) = ε                                      # Shift/Ramp
η(x) = σ                                      # Diffusion

# Simulation parameters
dt = 1e-1                                     # Timestep
Nt = 2e4                                      # Total number of steps
Ne = 1e2                                      # Number of particles in the ensemble 
