module StatisticalMethods

# Import packages
using LinearAlgebra, StatsBase
using Polynomials, Integrals
using ProgressMeter, LsqFit

# Import utility functions
include("../utils/stationary_processes.jl")
include("../utils/transient_processes.jl")

# Export namespaces
export fit_distribution, get_normalisation_constant, fit_potential
export get_window_parameters, detrend, find_tipping

end # module
