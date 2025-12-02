"""
    Simulation script

Storage of the definitions of the system alongside all the settings of the problem.
"""

# System parameters
μ0 = -1.00                                    # Initial parameter value
μf = 0.20                                     # Final parameter value
ε = 1e-2                                      # Slow timescale
σ = 0.050                                     # Noise level (additive)
D = (σ^2)/2.0                                 # Diffusion level (additive) 

# Dynamical system  
f(x, μ) = - μ - x^2                           # Drift
g(t) = ε                                      # Shift/Ramp
η(x) = σ                                      # Diffusion

# Initial condition 
equilibria = get_equilibria(f, μ0, domain=[-10,10])
x0 = [equilibria.stable[1], μ0]

# Timestep 
δt = 1e-3
