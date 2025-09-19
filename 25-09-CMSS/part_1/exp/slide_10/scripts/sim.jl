"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# System parameters
A = [[1.0, 0.5, 0.0, 1.0],                    # Coordination game
     [0.0, 2.0, 1.0, 3.0],                    # Dominant strategy (x1 stable)
     [1.0, 3.0, 0.0, 2.0],                    # Dominant strategy (x2 stable)
     [0.5, 1.0, 1.0, 0.0]]                    # Anti-coordination
σ = 0.000::Float64                            # Noise level (additive)
Nμ = length(A)

# Dynamical system  
f(x, μ) = x*(1 - x)*((μ[1] + μ[4] - μ[2] - μ[3])*x + μ[2] - μ[4]) # Drift
η(x) = σ                                      # Diffusion

# Time parameters
δt = 1e-2                                     # Timestep
Nt = convert(Int64, 1e3)                      # Total number of steps

# Initial conditions (ICs) 
Nx = 100 
u0 = collect(LinRange(0.05, 0.95, Nx))
