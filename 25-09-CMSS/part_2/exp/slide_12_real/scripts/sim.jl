"""
    Simulation script

Storage of the definitions of the system alongside all the settings of the problem.
"""

# System parameters
μ = 0.625::Float64                            # Bifurcation parameter value
σ = 0.500::Float64                            # Noise level (additive)
D = (σ^2)/2.0                                 # Diffusion level (additive) 

# Dynamical system  
f(x, μ) = -μ - 2*x + 3*(x^2) - (4/5)*(x^3)    # Drift
η(x) = σ                                      # Diffusion

# Initial condition 
equilibria = get_equilibria(f, μ, domain=[-10,10])
x0 = equilibria.stable[1]

# Time parameters
δt = 1e-2                                     # Timestep
Nt = convert(Int64, 5e6)                      # Total number of steps

# Ensemble parameters
Ne = convert(Int64, 1e0)
