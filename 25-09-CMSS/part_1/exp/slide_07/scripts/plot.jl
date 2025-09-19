"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

function plot_solution(t, u)
       # Extract the x and y component of the solution
        x = u[:,1]
        y = u[:,2]

        # Plot the trajectory in phase space
        lines!(ax1, x, y, color = (CtpGray,0.15), linewidth = 3.0)

        # Plot the timeseries along x
        lines!(ax2, t, x, color = (CtpGray,0.15), linewidth = 3.0)
end

function plot_highlight(t, u, color)
       # Extract the x and y component of the solution
        x = u[:,1]
        y = u[:,2]

        # Plot the trajectory in phase space
        lines!(ax1, x, y, color = color, linewidth = 6.0)

        # Plot the initial condition
        scatter!(ax1, x[1], y[1], color = color, markersize = 30, strokewidth = 3.0)

        # Plot the timeseries along x
        lines!(ax2, t, x, color = color, linewidth = 6.0)
end
