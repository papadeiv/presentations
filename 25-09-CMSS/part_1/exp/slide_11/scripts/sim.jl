"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# System parameters
a = -(0.25::Float64)
b = 1.20::Float64
c = -(0.40::Float64)
d = -(0.30::Float64)
e = 3.00::Float64
K = 2.00::Float64
ε = 5e-3                                                           # Timescale separation
σ = 0.000::Float64                                                 # Noise level (additive)

# Dynamical system  
f(x, λ) = -((x + a + b*λ)^2 + c*tanh(λ - d))*(x - K/(cosh(e*λ)))   # Drift
g(t) = ε                                                           # Shift 
η(x) = σ                                                           # Diffusion

# Time parameters
Δt = 5e-1                                                          # Timestamp for exporting the solution
T = 200.0                                                          # Time horizon
t∞ = [-T, +T]                                                      # Time interval
Nt = convert(Int64, 1e4)                                           # Total number of steps

# Initial condition (past limit system) 
x∞ = 0.20
λ∞ = -1.0
u∞ = [x∞,λ∞]
