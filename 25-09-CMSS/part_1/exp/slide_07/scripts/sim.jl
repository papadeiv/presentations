"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# System parameters
μ = 0.000::Float64                            # Bifurcation parameter value 
σ = 0.000::Float64                            # Noise level (additive)

# Dynamical system  
f(x, y, μ) = sqrt(abs(x))                     # Drift: x-component
g(x, y, μ) = -y                               # Drift: y-component
η(x, y) = σ                                   # Diffusion

# Initial conditions
Nx = 20
Ny = 20
x = collect(LinRange(-1,1,Nx))
y = collect(LinRange(-1,1,Ny))
u0 = [[x0,y0] for x0 in x for y0 in y]

# Time parameters
δt = 1e-3                                     # Timestep
Nt = convert(Int64, 5e3)                      # Total number of steps
