"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# System parameters
μ = 0.000::Float64                            # Bifurcation parameter value 
σ = 0.000::Float64                            # Noise level (additive)

# Dynamical system  
f(x, μ) =  x*(1 - x)*((3/2)*x - (1/2)) + μ    # Drift
η(x) = σ                                      # Diffusion

# Initial condition 
Nx = 30 
u0 = collect(LinRange(0.05, 0.95, Nx))

# Time parameters
δt = 1e-3                                     # Timestep
Nt = convert(Int64, 1e4)                      # Total number of steps
