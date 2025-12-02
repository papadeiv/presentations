"""
    Simulation script

Storage of the definitions of the system alongside all the settings of the problem.
"""

# System parameters
μ0 = -0.10                                    # Bifurcation parameter 
α = 2*sqrt(-μ0)                               # Linear decay rate 
σ = 0.250                                     # Noise level (additive)
D = (σ^2)/2.0                                 # Diffusion level (additive) 

# Dynamical system  
f1(x, y, μ) = -2*sqrt(-μ)*(x)                 # Drift: x-component
f2(x, y, μ) = - α*y                           # Drift: y-component
η(x, y) = σ                                   # Diffusion

# Initial conditions
ρ = 1.0
Nθ = convert(Int64, 4e3)
θ = collect(LinRange(0, 2*pi,Nθ+1)) 
u0 = [[ρ*cos(ω),ρ*sin(ω)] for ω in θ[1:end-1]]

# Radius of the circular region of first passage
R = 0.15

# Timestep 
δt = 1e-3
Nt = 5e4
