using CairoMakie, Makie.Colors, LaTeXStrings
using ProgressMeter, Revise
using Polynomials

# Avoid re-loading SimpleIO
if !isdefined(Main, :SimpleIO)
        include("../../src/SimpleIO.jl")
        using .SimpleIO
end

# Avoid re-loading SystemAnalysis 
if !isdefined(Main, :SystemAnalysis)
        include("../../src/SystemAnalysis.jl")
        using .SystemAnalysis
end

# Avoid re-loading StatisticalMethods
if !isdefined(Main, :StatisticalMethods)
        include("../../src/StatisticalMethods.jl")
        using .StatisticalMethods
end

# Avoid re-loading PlottingTools
if !isdefined(Main, :PlottingTools)
        include("../../src/PlottingTools.jl")
        using .PlottingTools
end
