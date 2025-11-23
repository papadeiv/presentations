"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Look-up list of plot actions depending on the position of the parameter in the bifurcation set
plot_action = Dict(
                   1 => (t, u, j) -> begin
                           # Define endtime
                           T = 1000
                           # Plot the timeseries before and after the tipping as well as the tipping treshold
                           lines!(ax1, t[1:j], u[1:j,1], color = (:black,1.00), linewidth = 3.0)
                           lines!(ax1, t[(j+1):end], u[(j+1):end], color = (:black,0.35), linewidth = 3.0)
                           lines!(ax1, [t[j],t[j]], [-10,10], color = :black, linewidth = 3.0, linestyle = :dash)
                           # Setup limits and ticks for the figure
                           y_range = maximum(filter(isfinite, u)) - max(minimum(filter(isfinite, u)), -1)
                           y_min = max(minimum(filter(isfinite, u)), -1) - 0.1*y_range
                           y_max = maximum(filter(isfinite, u)) + 0.1*y_range
                           ax1.limits = ((t[1],T),(y_min,y_max))
                           ax1.xticks = [t[1],T]
                           ax1.yticks = [y_min,y_max]
                   end,
                   2 => (t, u, j) -> begin
                           # Define endtime
                           T = 1000
                           # Plot the timeseries before and after the tipping as well as the tipping treshold
                           lines!(ax2, t[1:j], u[1:j,1], color = (:black,1.00), linewidth = 3.0)
                           lines!(ax2, t[(j+1):end], u[(j+1):end], color = (:black,0.35), linewidth = 3.0)
                           lines!(ax2, [t[j],t[j]], [-10,10], color = :black, linewidth = 3.0, linestyle = :dash)
                           # Setup limits and ticks for the figure
                           y_range = maximum(filter(isfinite, u)) - max(minimum(filter(isfinite, u)), -1)
                           y_min = max(minimum(filter(isfinite, u)), -1) - 0.1*y_range
                           y_max = maximum(filter(isfinite, u)) + 0.1*y_range
                           ax2.limits = ((t[1],T),(y_min,y_max))
                           ax2.xticks = [t[1],T]
                           ax2.yticks = [y_min,y_max]
                   end,
                   3 => (t, u, j) -> begin
                           # Define endtime
                           T = 1000
                           # Plot the timeseries before and after the tipping as well as the tipping treshold
                           lines!(ax3, t[1:j], u[1:j,1], color = (:black,1.00), linewidth = 3.0)
                           lines!(ax3, t[(j+1):end], u[(j+1):end], color = (:black,0.35), linewidth = 3.0)
                           lines!(ax3, [t[j],t[j]], [-10,10], color = :black, linewidth = 3.0, linestyle = :dash)
                           # Setup limits and ticks for the figure
                           y_range = maximum(filter(isfinite, u)) - max(minimum(filter(isfinite, u)), -1)
                           y_min = max(minimum(filter(isfinite, u)), -1) - 0.1*y_range
                           y_max = maximum(filter(isfinite, u)) + 0.1*y_range
                           ax3.limits = ((t[1],T),(y_min,y_max))
                           ax3.xticks = [t[1],T]
                           ax3.yticks = [y_min,y_max]
                   end,
                   4 => (t, u, j) -> begin
                           # Define endtime
                           T = 1000
                           # Plot the timeseries before and after the tipping as well as the tipping treshold
                           lines!(ax4, t[1:j], u[1:j,1], color = (:black,1.00), linewidth = 3.0)
                           lines!(ax4, t[(j+1):end], u[(j+1):end], color = (:black,0.35), linewidth = 3.0)
                           lines!(ax4, [t[j],t[j]], [-10,10], color = :black, linewidth = 3.0, linestyle = :dash)
                           # Setup limits and ticks for the figure
                           y_range = maximum(filter(isfinite, u)) - max(minimum(filter(isfinite, u)), -1)
                           y_min = max(minimum(filter(isfinite, u)), -1) - 0.1*y_range
                           y_max = maximum(filter(isfinite, u)) + 0.1*y_range
                           ax4.limits = ((t[1],T),(y_min,y_max))
                           ax4.xticks = [t[1],T]
                           ax4.yticks = [y_min,y_max]
                   end
                  )

# Plot the sample path 
function plot_solution(time, variable, treshold, plot_index)
        # Peform action according to the plot index
        action = plot_action[plot_index] 
        action(time, variable, treshold)
end

# Plot the ews 
function plot_solution(time, observable, treshold, time_ews, var_ews)
        # Define endtime
        T = 1000

        # Up until the tipping
        lines!(ax5, time[1:treshold], observable[1:treshold], color = (:black,1.00), linewidth = 3.0)
        # After the tipping
        lines!(ax5, time[(treshold+1):end], observable[(treshold+1):end], color = (:black,0.35), linewidth = 3.0)

        # Plot the variance
        lines!(ax6, time_ews, var_ews, color = CtpRed, linewidth = 4.0)

        # Setup limits and ticks for the figure
        y_range = maximum(filter(isfinite, observable)) - max(minimum(filter(isfinite, observable)), -1)
        y_min = max(minimum(filter(isfinite, observable)), -1) - 0.1*y_range
        y_max = maximum(filter(isfinite, observable)) + 0.1*y_range
        ax5.limits = ((time[1],T),(y_min,y_max))
        ax6.limits = ((time[1],T),(0,0.025))
        ax5.xticks = [time[1],T]
        ax6.xticks = [time[1],T]
        ax5.yticks = [y_min,y_max]
        ax6.yticks = [0,0.025]

        # Plot a dashed line indicating the tipping
        lines!(ax5, [time[treshold],time[treshold]], [y_min,y_max], color = :black, linewidth = 3.0, linestyle = :dash)
        lines!(ax6, [time[treshold],time[treshold]], [-1,5], color = :black, linewidth = 3.0, linestyle = :dash)
end
