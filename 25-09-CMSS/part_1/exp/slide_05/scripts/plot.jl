"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the timeseries 
function plot_solutions(time, solutions)
        # Define color range for the plots
        color_range = collect(LinRange(0,1,length(time)))

        # Plot the 1 solution asymptotic to the stable equilibrium 1 and itself
        lines!(ax1, time, [1.00 for n in 1:length(time)], color = :black, linewidth = 5.0)
        lines!(ax1, time, trajectories[17], color = trajectories[17], colormap = [(CtpYellow,1.0),(CtpMauve,1.0)], colorrange = (0,1), linewidth = 5.0)
        # Set up the limits and ticks of the figure
        ax1.limits = ((time[1], time[end]), (-0.05, 1.05)) 
        ax1.xticks = [time[1], time[round(Int,length(time)/2)], time[end]]
        ax1.yticks = [0, 0.5, 1]

        # Plot 2 solutions asymptotic to both 0 and 1 and themselves
        lines!(ax2, time, [0.00 for n in 1:length(time)], color = :black, linewidth = 5.0)
        lines!(ax2, time, trajectories[5], color = trajectories[10], colormap = [(CtpYellow,1.0),(CtpMauve,1.0)], colorrange = (0,1), linewidth = 5.0)
        lines!(ax2, time, [1.00 for n in 1:length(time)], color = :black, linewidth = 5.0)
        lines!(ax2, time, trajectories[17], color = trajectories[17], colormap = [(CtpYellow,1.0),(CtpMauve,1.0)], colorrange = (0,1), linewidth = 5.0)
        # Set up the limits and ticks of the figure
        ax2.limits = ((time[1], time[end]), (-0.05, 1.05)) 
        ax2.xticks = [time[1], time[round(Int,length(time)/2)], time[end]]
        ax3.yticks = [0, 0.5, 1]

        # Loop over the initial conditions 
        for n in 1:Nx
                # Plot all the solutions
                lines!(ax3, time, trajectories[n], color = trajectories[n], colormap = [(CtpYellow,1.0),(CtpMauve,1.0)], colorrange = (0,1), linewidth = 5.0)
        end
        # Plot the equilibria
        lines!(ax3, time, [1.000 for n in 1:length(time)], color = :black, linewidth = 5.0)
        lines!(ax3, time, [0.345 for n in 1:length(time)], color = :black, linewidth = 5.0, linestyle = :dash)
        lines!(ax3, time, [0.000 for n in 1:length(time)], color = :black, linewidth = 5.0)
        # Set up the limits and ticks of the figure
        ax3.limits = ((time[1], time[end]), (-0.05, 1.05)) 
        ax3.xticks = [time[1], time[round(Int,length(time)/2)], time[end]]
        ax3.yticks = [0, 0.5, 1]
end
