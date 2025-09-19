module SystemAnalysis

# Import packages
using LinearAlgebra, DifferentialEquations
using Roots, ForwardDiff

# Import utility functions
include("../utils/evolve_1d_systems.jl")
include("../utils/evolve_2d_systems.jl")
include("../utils/analyse_system.jl")

# Export namespaces
export evolve_1d, evolve_shifted_1d
export evolve_2d, evolve_shifted_2d
export get_equilibria

end # module
