"""
    Plotting script

Collection of all the functions used to generate and properly format the figures of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the LDP of two paths 
function plot(termination, total_time)
        # Rename variables
        Y = termination
        T = total_time
        time = collect(LinRange(0,T,5000))

        # Plot the hitting target
        lines!(ax1, [0,T], [Y, Y], color = :black, linewidth = 5.0, linestyle = :dash)

        # Plot the minimiser of the action
        lines!(ax2, [0,T], [Y^2, Y^2], color = :black, linewidth = 5.0, linestyle = :dash)

        # Plot the full paths 
        lines!(ax1, time, [ɸ1(t) for t in time], color = CtpRed, linewidth = 5.0)
        lines!(ax1, time, [ɸ2(t) for t in time], color = CtpBlue, linewidth = 5.0)

        # Plot the LDP of the paths
        time = collect(LinRange(0,4,5000))
        lines!(ax2, time, [S1(t) for t in time], color = CtpRed, linewidth = 5.0)
        lines!(ax2, time, [S2(t) for t in time], color = CtpBlue, linewidth = 5.0)
end
