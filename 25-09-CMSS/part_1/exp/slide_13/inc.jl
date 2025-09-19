using CairoMakie, Makie.Colors
using LaTeXStrings
using ProgressMeter

# Avoid re-loading PlottingTools 
if !isdefined(Main, :PlottingTools)
        include("../../src/PlottingTools.jl")
        using .PlottingTools
end

# Avoid re-loading SystemAnalysis 
if !isdefined(Main, :SystemAnalysis)
        include("../../src/SystemAnalysis.jl")
        using .SystemAnalysis
end
