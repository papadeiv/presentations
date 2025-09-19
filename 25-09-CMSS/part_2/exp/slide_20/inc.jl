using CairoMakie, Makie.Colors
using LaTeXStrings
using Distributions 
using ProgressMeter, Revise

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

# Avoid re-loading PlottingTools 
if !isdefined(Main, :PlottingTools)
        include("../../src/PlottingTools.jl")
        using .PlottingTools
end
