"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

function plot_timeseries(May, deMonecal, Diks)
        # Extract and plot May's data 
        t = May.time
        u = May.states
        lines!(ax1, t, u, color = CtpRed, linewidth = 3.0)
        
        # Extract and plot deMonecal's data 
        t = deMonecal[:,1].*1e-3
        u = deMonecal[:,2]
        lines!(ax2, t, u, color = CtpRed, linewidth = 3.0)
 
        # Extract and plot deMonecal's data 
        u = Diks[150:end].*1e-3
        t = LinRange(1,length(u),length(u))
        lines!(ax3, t, u, color = CtpRed, linewidth = 3.0)
        labels = ["Jan. '08", "June '09"]
        ax3.xtickformat = values -> ["$(label)" for label in labels]
end
