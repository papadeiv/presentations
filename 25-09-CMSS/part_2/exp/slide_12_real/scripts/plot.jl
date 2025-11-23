"""
    Plotting script

Collection of all the functions used to generate and properly format the figures of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

function plot_potential(solution, μ)
        # Define the x-range for the domain
        domain = collect(LinRange(-1.0,3.5,1000))
        # Plot the scalar potential
        lines!(ax1, domain, [U(x, μ) for x in domain], color = :black, linewidth = 6)
        # Plot the ball in the potential
        scatter!(ax1, solution[1], U(solution[1], μ), color = (CtpMauve, 1.0), markersize = 45, strokewidth = 3)
end

function plot_distribution(μ)
        # Define the x-range for the domain
        domain = collect(LinRange(-1.0,3.5,1000))
        # Plot the density function 
        lines!(ax1, domain, [ρ(x, μ) for x in domain], color = [ρ(x, μ) for x in domain], colormap = [CtpYellow, CtpMauve], linewidth = 6)
end

function plot_solution(time, solution, μ)
        # Plot the timeseries
        lines!(ax2, time, solution, color = [ρ(x, μ) for x in solution], colormap = [CtpYellow, CtpMauve], linewidth = 3.0)

        # Setup limits and ticks
        ax2.limits = ((time[1],time[end]),(minimum(solution),maximum(solution)))
        ax2.xticks = [time[1],time[end]]
        ax2.yticks = [minimum(solution),equilibria.stable[1], equilibria.stable[2], maximum(solution)]

        # Fit and plot a histogram to the timeseries
        bins, pdf = fit_distribution(solution, n_bins = Nb)
        barplot!(ax1, bins, pdf, color = pdf, colormap = [(CtpWhite,1.0),(CtpGray,1.0)], strokecolor = :black, strokewidth = 1)

        # Define the x-range for the domain
        domain = collect(LinRange(-1.0,3.5,1000))
 
        # Replot the objects in Figures 1 and 2 so that they appear on top of the histogram
        lines!(ax1, domain, [U(x, μ) for x in domain], color = :black, linewidth = 6)
        scatter!(ax1, solution[1], U(solution[1], μ), color = (CtpMauve, 1.0), markersize = 45, strokewidth = 3)
        lines!(ax1, domain, [ρ(x, μ) for x in domain], color = [ρ(x, μ) for x in domain], colormap = [CtpYellow, CtpMauve], linewidth = 6)
end
