"""
    Plotting script

Collection of all the functions used to generate and properly format the figures of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the variance timeseries 
function plot(ews)
        # Plot the full timeseries 
        lines!(ax1, ews.parameter[1:(end-1)], ews.signal[1:(end-1)], color = (:black,0.05), linewidth = 2.0)
end

# Highlight good and bad early-warning signals 
function highlight(bad_μ, bad_ews, good_μ, good_ews)
        # Plot the good ews 
        lines!(ax1, good_μ[1:(end-1)], good_ews[1:(end-1)], color = CtpGreen, linewidth = 5.0)
        # Plot the bad ews 
        lines!(ax1, bad_μ[1:(end-1)], bad_ews[1:(end-1)], color = CtpRed, linewidth = 5.0)
end
