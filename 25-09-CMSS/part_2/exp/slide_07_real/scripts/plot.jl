"""
    Plotting script

Functions used to create the plots in each figure.
"""

# Create empty layouts for the figures
include("./figs.jl")

function plot_solution(solution)
       # Extract the x and y component of the solutions
        x = solution[:,1]
        y = solution[:,2]

        # Plot the nonlinear trajectory in phase space
        lines!(ax1, x, y, color = (CtpGray,0.75), linewidth = 0.05)

        # Plot the stable manifolds for the sink and unstable manifolds
        domain_x = collect(LinRange(-1.0,+1.0,1000))
        domain_y = collect(LinRange(-1.0,+1.0,1000))
        lines!(ax1, domain_x, [0 for x in domain_x], color = CtpBlue, linewidth = 5.0)
        lines!(ax1, [0 for y in domain_y], domain_y, color = CtpBlue, linewidth = 5.0)
        # Plot the stable eigenvectors
        x_p = [0, 0, -1, 1]
        v_x = [0, 0, 1, -1]
        y_p = [-1, 1, 0, 0]
        v_y = [1, -1, 0, 0]
        arrows!(ax1, x_p, y_p, v_x, v_y, color = CtpBlue, arrowsize = 30, lengthscale = 0.1, linewidth = 5, align = :tip)

        # Plot the equilibrium
        scatter!(ax1, 0.0, 0.0, color = CtpBlue, markersize = 30, strokewidth = 3.0)
end

function plot_solution(solution, overload_keyword::String)
        # Extract the x and y component of the solutions
        x = solution[:,1]
        y = solution[:,2]

        # Initialise the time index of first passage
        idx = 0::Int64

        # Loop over the realisations of the timeseries
        for n in 1:length(x)
                # Check first passage
                if sqrt(x[n]^2 + y[n]^2) < R 
                        idx = n
                        break
                end
        end

        # Plot a circle around the saddle equilibria marking the neighbourhood
        lines!(ax1, Circle(Point2f(0, 0), R), color = :black, linewidth = 5.0, linestyle = :dash)

        # Plot the nonlinear trajectory in phase space truncated to the first passage
        lines!(ax1, x[1:idx], y[1:idx], color = (CtpMauve,1.00), linewidth = 3.00)

        # Plot the initial condition 
        scatter!(ax1, x[1], y[1], color = CtpMauve, markersize = 30, strokewidth = 3.0)
end

function plot_first_passage(variables)
        # Compute the number of bins
        Nb = convert(Int64, 0.01*length(variables))

        # Fit and plot a histogram to the first passage time 
        bins, pdf = fit_distribution(variables, n_bins=Nb)
        barplot!(ax2, bins, pdf, color = pdf, colormap = [(CtpYellow,1.0),(CtpMauve,1.00)], strokecolor = :black, strokewidth = 1)

        # Set up ticks and limits
        ax2.limits = ((0,8),(0,1.6))
        ax2.xticks = [0,4,8]
        ax2.yticks = [0,0.4,0.8,1.2,1.6]
end
