"""
    Postprocessing script

In here we define the quantities related to the computation of EWSs from raw data.
"""

# Parameters of the scalar potential method
Nb = 200 

# Scalar potential of the conservative system 
U(x, μ) = μ*x + x^2 - x^3 + (1/5)*(x^4)

# Stationary probability distribution
p(x, μ) = exp(-(1.0::Float64/D)*(U(x, μ)))
N(μ) = get_normalisation_constant(p, μ, (-Inf, Inf))
ρ(x, μ) = N(μ)*p(x, μ)
