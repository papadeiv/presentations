"""
    Postprocessing script

Collection of quantities and functions used to postprocess and analyse the results of a simulation.
"""

# Data structures for storing the results
solutions = Vector{Matrix{Float64}}()          # Solutions of the IVP for different initial conditions 
