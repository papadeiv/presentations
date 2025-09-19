"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# System parameters
μ = 0.000::Float64                            # Bifurcation parameter value 
σ = 0.000::Float64                            # Noise level (additive)

# Dynamical system  
f(x, y, μ) = x*(1 - x - y)                    # Drift: x-component
g(x, y, μ) = y*(2 - x - 2*y)                  # Drift: y-component
η(x, y) = σ                                   # Diffusion

# Linearisation about (1,0)
Df(x, y, μ) = - x - y
Dg(x, y, μ) = y
Dη(x, y) = σ

# Initial conditions
Nx = 40
Ny = 40
x = collect(LinRange(-3,3,Nx))
y = collect(LinRange(-3,3,Ny))
u0 = [[x0,y0] for x0 in x for y0 in y]

# Initial conditions (close-up)
x = collect(LinRange(0.25,1.75,Nx))
y = collect(LinRange(-0.75,0.75,Ny))
u0_close = [[x0,y0] for x0 in x for y0 in y]

# Time parameters
δt = 1e-3                                     # Timestep
Nt = convert(Int64, 5e3)                      # Total number of steps
