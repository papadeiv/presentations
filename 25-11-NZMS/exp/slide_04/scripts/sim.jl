"""
    Simulation script

Storage of the definitions of the system alongside all the settings of the problem.
"""

# System parameters
μ0 = -(1.00::Float64)                         # Initial parameter value
μf = 0.00::Float64                            # Final parameter value
ε = 1e-2                                      # Timescale separation
σ = 0.100::Float64                            # Noise level (additive)
D = (σ^2)/2.0                                 # Diffusion level (additive) 

# Dynamical system  
f(x, μ) = -μ - x^2                            # Drift
Λ(t) = ε                                      # Shift/Ramp
η(x) = σ                                      # Diffusion

# Initial condition 
equilibria = get_equilibria(f, μ0, domain=[-10,10])
x0 = [equilibria.stable[1], μ0]

# Simulation parameters
dt = 1e-3                                     # Timestep
Ne = 1e3                                      # Number of particles in the ensemble 
