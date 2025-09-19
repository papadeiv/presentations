"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the sample path 
function plot_tip(x_data, y_data, treshold)
        # Up until the tipping
        lines!(ax1, x_data[1:treshold], y_data[1:treshold], color = (:black,1.00), linewidth = 3.0)
        # After the tipping
        lines!(ax1, x_data[(treshold+1):end], y_data[(treshold+1):end], color = (:black,0.50), linewidth = 3.0)

        # Setup limits and ticks for the figure
        y_range = maximum(y_data) - minimum(y_data)
        y_min = minimum(y_data) - 0.1*y_range
        y_max = maximum(y_data) + 0.1*y_range
        ax1.limits = ((x_data[1],x_data[end]),(y_min,y_max))
        ax1.xticks = [x_data[1],x_data[end]]
        ax1.yticks = [y_min,y_max]
end
