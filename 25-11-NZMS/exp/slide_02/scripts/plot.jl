"""
    Plotting script

Collection of all the functions used to generate and properly format the figures of the simulations.
"""

using PyCall

# Create empty layouts for the figures
include("./figs.jl")

# Plot the timeseries and the solution of the nonlinear reconstruction of the potential
function plot(timesteps, timeseries, ews, tipping_point)
        # Plot the full timeseries 
        lines!(ax1, timesteps, timeseries, color = (:black,1.0), linewidth = 3.0)

        # Setup ticks and limits for the plot
        y_range = maximum(timeseries) - minimum(timeseries)
        ax1.limits = ((timesteps[1], timesteps[end]), (minimum(timeseries) - 0.1*y_range, maximum(timeseries) + 0.1*y_range))
        ax1.xticks = [timesteps[1], timesteps[end]]
        ax1.yticks = [minimum(timeseries) - 0.1*y_range, maximum(timeseries) + 0.1*y_range]

        # Export the figure
        savefig("slide_02_1.png", fig1)

        # Plot the timeseries sections 
        lines!(ax2, timesteps[1:tipping_point], timeseries[1:tipping_point], color = (CtpBlue,1.0), linewidth = 3.0)
        lines!(ax2, timesteps[(tipping_point-200):(tipping_point+transition)], timeseries[(tipping_point-200):(tipping_point+transition)], color = (CtpRed,1.0), linewidth = 3.0)
        lines!(ax2, timesteps[(tipping_point+transition):end], timeseries[(tipping_point+transition):end], color = (CtpBlue,1.0), linewidth = 3.0)

        # Setup ticks and limits for the plot
        ax2.limits = ((timesteps[1], timesteps[end]), (minimum(timeseries) - 0.1*y_range, maximum(timeseries) + 0.1*y_range))
        ax2.xticks = [timesteps[1], timesteps[end]]
        ax2.yticks = [minimum(timeseries) - 0.1*y_range, maximum(timeseries) + 0.1*y_range]

        # Export the figure
        savefig("slide_02_2.png", fig2)

        # Plot May's vegetation model
        May = evolve_may(1e-2, 3.52)
        lines!(ax3, May.time, May.state[1], color = CtpRed, linewidth = 3.0)

        # Plot deMonecal's data on the end of teh African humid period
        fullpath = "../../res/data/slide_02/deMonecal00.csv" 
        df = DataFrame(CSV.File(fullpath; delim=',', header=false))
        data = Matrix{Float64}(undef, nrow(df), ncol(df))
        for n in 1:ncol(df)
                data[:,n] = df[:,n]
        end
        t = data[:,1].*1e-3
        u = data[:,2]
        lines!(ax4, t, u, color = CtpRed, linewidth = 3.0)

        # Plot Diks data on the 2008 financial crisis
        fullpath = "../../res/data/slide_02/Diks18.csv"
        df = DataFrame(CSV.File(fullpath; delim=',', header=false))
        data = Matrix{Float64}(undef, nrow(df), ncol(df))
        for n in 1:ncol(df)
                data[:,n] = df[:,n]
        end
        u = data[150:end].*1e-3
        t = LinRange(1,length(u),length(u))
        lines!(ax5, t, u, color = CtpRed, linewidth = 3.0)
        labels = ["Jan. '08", "June '09"]
        ax5.xtickformat = values -> ["$(label)" for label in labels]

        # Export the figure
        savefig("slide_02_3.png", fig3)

        # Plot hand-sketched graph
        funny = evolve_may(1e0, 3.0)
        py"""
        def plot_funny(time, state):
                import matplotlib.pyplot as plt
                from matplotlib import font_manager as fm
                import numpy as np

                comic_font = fm.FontProperties(fname="/home/dpap666/.fonts/xkcd-script.ttf")

                with plt.xkcd():
                        fig = plt.figure(figsize=[9.6,7.2], dpi=200.0)
                        fig.suptitle('A PhD\'s tipping point in imposter syndrome', fontproperties=comic_font, size = 'large')
                        ax = fig.add_axes((0.1, 0.2, 0.8, 0.7))
                        ax.spines[['top', 'right']].set_visible(False)
                        ax.set_xticks([37.5, 75, 112.5, 150], labels=["year 1", "year 2", "year 3", "year 4"], fontproperties=comic_font, size = 'large')
                        ax.set_yticks([])
                        ax.set_ylabel("confidence in my skills", fontproperties=comic_font, size = 'large')                

                        ax.plot(time, state)

                        plt.savefig("../../res/fig/slide_02_4.png")
        """

        # Export the figure
        py"plot_funny"(funny.time, funny.state[1])

        # Plot the timeseries sections 
        lines!(ax7, timesteps[1:tipping_point], timeseries[1:tipping_point], color = (CtpTeal,1.0), linewidth = 3.0)
        lines!(ax7, timesteps[tipping_point:end], timeseries[tipping_point:end], color = (CtpTeal,0.5), linewidth = 3.0)

        # Setup ticks and limits for the plot
        ax7.limits = ((timesteps[1], timesteps[end]), (minimum(timeseries) - 0.1*y_range, maximum(timeseries) + 0.1*y_range))
        ax7.xticks = [timesteps[1], timesteps[end]]
        ax7.yticks = [minimum(timeseries) - 0.1*y_range, maximum(timeseries) + 0.1*y_range]

        # Plot the dashed line indicating the tipping point
        lines!(ax7, [timesteps[tipping_point], timesteps[tipping_point]], [minimum(timeseries) - 0.1*y_range, maximum(timeseries) + 0.1*y_range], color = :black, linestyle = :dash, linewidth = 3.0)

        # Plot the increase in variance EWS
        lines!(ax8, ews.time, ews.signal, color = CtpMauve, linewidth = 3.0)

        # Setup ticks and limits for the plot
        y_range = maximum(ews.signal) - minimum(ews.signal)
        ax8.limits = ((timesteps[1], timesteps[end]), (minimum(ews.signal) - 0.1*y_range, maximum(ews.signal) + 0.1*y_range))
        ax8.xticks = [timesteps[1], timesteps[end]]
        ax8.yticks = [minimum(ews.signal) - 0.1*y_range, maximum(ews.signal) + 0.1*y_range]

        # Plot the dashed line indicating the tipping point
        lines!(ax8, [timesteps[tipping_point], timesteps[tipping_point]], [minimum(ews.signal) - 0.1*y_range, maximum(ews.signal) + 0.1*y_range], color = :black, linestyle = :dash, linewidth = 3.0)

        # Export the figure
        savefig("slide_02_5.png", fig7)
end
