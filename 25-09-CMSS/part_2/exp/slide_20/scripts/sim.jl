"""
    Simulation script

This is where we store the definition of the system alongside all the settings of the problem.
"""

# Define the stationary parameters of the process
σ = 0.1        # Level of (additive) noise
ε = 0.01       # Timescale of the slow ramping of the forcing parameter
r = 1.0        # Growth rate
k = 10.0       # Carrying capacity
Vh = 1.0       # Half-grazing biomass

# Define the forcing parameter endstate
cT = 3.52

# Define the vegetation dynamics model (May 1977) 
f(x, μ) = r*x*(1.0-(1.0/k)*x) - μ*((x^2)/((x^2) + (Vh^2)))
g(x) = ε
η(x) = σ

# Time parameters
T = 200.0                                                          # Time horizon
t∞ = [0, +T]                                                       # Time interval
Nt = convert(Int64, 1e4)                                           # Total number of steps

# Initial condition 
V0 = 8.0       # Vegetation biomass (state)
c0 = 1.5       # Grazing rate (forcing parameter)
x0 = [V0, c0]
