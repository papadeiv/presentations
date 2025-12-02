"""
    Simulation script

Storage of the definitions of the system alongside all the settings of the problem.
"""

# System parameters
μ0 = -(0.9::Float64)                          # Initial parameter value
μf = 0.10::Float64                            # Final parameter value
ε = 1e-3                                      # Slow timescale
σ = 0.100::Float64                            # Noise level (additive)
D = (σ^2)/2.0                                 # Diffusion level (additive) 

# Dynamical system
f1(x, y, μ) = - μ - x^2                       # Drift: x-component
f2(x, y, μ) = - y                             # Drift: y-component
g(t) = ε                                      # Shift/Ramp
η(x, y) = σ                                   # Diffusion

# Initial condition 
equilibria = get_equilibria(f1, f2, μ0)
x0 = vcat(equilibria.stable[1], μ0)

# Timestep 
δt = 1e-2
