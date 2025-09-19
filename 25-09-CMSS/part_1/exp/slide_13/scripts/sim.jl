"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# System parameters
ε = 1e-3                                                           # Timescale separation
σ = 0.000::Float64                                                 # Noise level (additive)

# Dynamical system  
f1(x, y, λ) = λ - x^2 - 0.1*x^3                                    # Drift: x-component
f2(x, y, λ) = - y + x                                              # Drift: y-component
Λ(t) = 5.0*ε*(sech(ε*t))^2                                         # Shift 
η(x, y) = σ                                                        # Diffusion

# Time parameters
T = 50.0                                                           # Time horizon
t∞ = [-T, +T]                                                      # Time interval
Nt = convert(Int64, 1e4)                                           # Total number of steps

# Initial condition (past limit system) 
Nx = 200
x∞ = collect(LinRange(-1, 1, Nx))
Ny = 200
y∞ = collect(LinRange(-1, 1, Ny))
λ∞ = 0.00
u∞ = [[x,y,λ∞] for x in x∞ for y in y∞]
