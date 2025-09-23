"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the timeseries
function plot_timeseries(time, states)
        # Plot the solution
        lines!(ax1, time, states, color = (CtpRed, 1.00), linewidth = 2.0)

        # Format limits and ticks
        ax1.limits = ((time[1],time[end]),(-1.125,1.125))
        ax1.xticks = [time[1],time[end]]
        ax1.yticks = [-1,0,1]
end

# Plot the location of the empirical tipping point 
function plot_tipping(tipping_time)
        lines!(ax1, [tipping_time,tipping_time], [-1.125,1.125], color = (:black, 1.00), linewidth = 3.0)
end

# Plot the location of the true tipping point 
function plot_bifurcation(time, parameters)
        # Extract the time index of the bifurcation
        bif_idx = findfirst(μ -> μ > 0, parameters)
 
        # Plot the location of the bifurcation
        lines!(ax1, [time[bif_idx],time[bif_idx]], [-1.125,1.125], color = (:black, 0.50), linewidth = 3.0)
end

# Plot the bifurcation diagram
function plot_bif_diag(time, parameters)
        # Extract the parameter values until the bifurcation
        bif_idx = findfirst(μ -> μ > 0, parameters) - 1
        μ = parameters[1:bif_idx]
        t = time[1:bif_idx]
        
        # Plot the drifting quasi-steady equilibria
        lines!(ax1, t, -1.0.*sqrt.(-1.0.*μ), color = :black, linewidth = 3.0, linestyle = :dash)
        lines!(ax1, t, +1.0.*sqrt.(-1.0.*μ), color = :black, linewidth = 3.0)
end
