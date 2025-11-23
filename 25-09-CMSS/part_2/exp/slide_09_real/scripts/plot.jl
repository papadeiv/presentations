"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the sample path 
function plot_solution(time, solution, treshold)
        # Up until the tipping
        lines!(ax1, time[1:treshold], solution[1:treshold], color = (:black,1.00), linewidth = 3.0)
        # After the tipping
        lines!(ax1, time[(treshold+1):end], solution[(treshold+1):end], color = (:black,0.35), linewidth = 3.0)

        # Setup limits and ticks for the figure
        y_range = maximum(filter(isfinite, solution)) - max(minimum(filter(isfinite, solution)), -1)
        y_min = max(minimum(filter(isfinite, solution)), -1) - 0.1*y_range
        y_max = maximum(filter(isfinite, solution)) + 0.1*y_range
        ax1.limits = ((time[1],time[end]),(y_min,y_max))
        ax2.limits = ((time[1],time[end]),(0,0.05))
        ax1.xticks = [time[1],time[end]]
        ax2.xticks = [time[1],time[end]]
        ax1.yticks = [y_min,y_max]
        ax2.yticks = [0,0.05]

        # Plot a dashed line indicating the tipping
        lines!(ax1, [time[treshold],time[treshold]], [y_min,y_max], color = :black, linewidth = 3.0, linestyle = :dash)
        lines!(ax2, [time[treshold],time[treshold]], [-1,5], color = :black, linewidth = 3.0, linestyle = :dash)
end

# Plot the variance ews 
function plot_window(window, time, ews)
        # Plot the variance
        lines!(ax2, time, ews, color = CtpRed, linewidth = 4.0)
        
        # Plot the sliding window
        poly!(ax1, Point2f[(window[1], -2), (window[end], -2), (window[end], 5), (window[1], 5)], color = (CtpBlue, 0.25), strokecolor = :grey, strokewidth = 0.05)
        poly!(ax2, Point2f[(window[1], -2), (window[end], -2), (window[end], 5), (window[1], 5)], color = (CtpBlue, 0.25), strokecolor = :grey, strokewidth = 0.05)

        # Plot the value of the variance at the current position of the sliding window
        scatter!(ax2, time[end], ews[end], color = CtpRed, markersize = 30, strokewidth = 3.0)
end
