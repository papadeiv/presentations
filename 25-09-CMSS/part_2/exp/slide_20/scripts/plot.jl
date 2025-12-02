"""
    Plotting script

Functions used to create the plots in each figure.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the full solution, escape early-warning and numerical error 
function plot_ews(time, solution, treshold, data)
        # Extract the ews and error 
        mat = transpose(reduce(hcat, data))
        ews, error = eachcol(mat)

        # Setup ticks and limits of the plot
        y_range = maximum(solution) - minimum(solution)
        y_min, y_max = minimum(solution) - 0.1*y_range, maximum(solution) + 0.1*y_range 
        ax1.limits = ((time[1],time[end]),(y_min,y_max))
        ax1.xticks = [time[1],time[end]]
        ax1.yticks = [y_min,y_max]
        lines!(ax1, [time[treshold],time[treshold]], [y_min,y_max], color = :black, linewidth = 3.0, linestyle = :dash)

        y_range = maximum(ews) - minimum(ews)
        y_min, y_max = minimum(ews) - 0.1*y_range, maximum(ews) + 0.1*y_range 
        ax2.limits = ((time[1],time[end]),(y_min,y_max))
        ax2.xticks = [time[1],time[end]]
        ax2.yticks = [y_min,y_max]
        lines!(ax2, [time[treshold],time[treshold]], [y_min,y_max], color = :black, linewidth = 3.0, linestyle = :dash)

        y_min, y_max = 0, 1.1*maximum(error)
        ax3.limits = ((time[1],time[end]),(y_min,y_max))
        ax3.xticks = [time[1],time[end]]
        ax3.yticks = [y_min,y_max]
        lines!(ax3, [time[treshold],time[treshold]], [y_min,y_max], color = :black, linewidth = 3.0, linestyle = :dash)

        # Extract timesteps of the ews
        time_ews = time[(treshold-length(ews)):(treshold-1)]

        # Plot the 3 timeseries
        lines!(ax1, time[1:treshold], solution[1:treshold], color = :black, linewidth = 3.0)
        lines!(ax1, time[(treshold+1):end], solution[(treshold+1):end], color = (:black,0.35), linewidth = 3.0)
        lines!(ax2, time_ews, ews, color = CtpRed, linewidth = 3.0)
        lines!(ax3, time_ews, error, color = CtpBlue, linewidth = 3.0)
end
