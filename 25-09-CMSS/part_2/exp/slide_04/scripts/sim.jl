"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# System parameters
μ0 = -1.00                                    # Bifurcation parameter 
α = 1.00                                      # Linear decay rate 
σ = 0.000                                     # Noise level (additive)
D = (σ^2)/2.0                                 # Diffusion level (additive) 

# Dynamical system  
f1(x, y, μ) = - μ - x^2                       # Drift: x-component
f2(x, y, μ) = - α*y                           # Drift: y-component
η(x, y) = σ                                   # Diffusion

# Initial conditions
Nx = 100
Ny = 100
x = collect(LinRange(-1.5,+1.5,Nx))
y = collect(LinRange(-0.5,+0.5,Ny))
u0 = [[x0,y0] for x0 in x for y0 in y]

# Timestep 
δt = 1e-3
Nt = 1e4
