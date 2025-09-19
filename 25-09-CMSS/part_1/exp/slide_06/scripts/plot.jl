"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the dynamics function and the scalar potential 
function plot_figures(μ)
        # Define the domain
        domain = collect(LinRange(-0.5,1.5,1000))

        # Compute the stable and unstable equilibria
        equilibria = get_equilibria(f, μ[1], domain=[-10,10])

        # Plot the x- and y-axis
        lines!(ax1, [domain[1], domain[end]], [0.0, 0.0], color = (:black, 0.25), linewidth = 1.0)
        lines!(ax1, [0,0], [-0.5, 0.5], color = (:black, 0.25), linewidth = 1.0)
        # Plot the dynamics function 
        lines!(ax1, domain, [f(x,μ) for x in domain], color = CtpMauve, linewidth = 5.0)
        # Set up the limits and ticks of the figure
        ax1.limits = ((domain[1], domain[end]), (-0.5, 0.5)) 
        ax1.yticks = [-0.5, 0, 0.5]
        # Print the parameter value
        ax1.title = L"\mathbf{\mu = %$(trunc(μ, digits=3))}"
        
        # Plot the potential 
        lines!(ax2, domain, [V(x,μ) for x in domain], color = CtpTeal, linewidth = 5.0)
        # Set up the limits and ticks of the figure
        ax2.limits = ((domain[1], domain[end]), (-0.1, 0.1)) 
        ax2.yticks = [-0.1, 0, 0.1]
        # Print the parameter value
        ax2.title = L"\mathbf{\mu = %$(trunc(μ, digits=3))}"

        # Plot and add the ticks of the equilibria at current parameter value
        if μ > 0.0
                scatter!(ax1, 0.1504721, f(0.1504721, μ), color = CtpYellow, markersize = 30, strokewidth = 3.0)
                scatter!(ax1, equilibria.stable[1], f(equilibria.stable[1], μ), color = CtpBlue, markersize = 30, strokewidth = 3.0)
                ax1.xticks = [domain[1], 0.1504721, equilibria.stable[1], domain[end]]
                scatter!(ax2, 0.1504721, V(0.1504721, μ), color = CtpYellow, markersize = 30, strokewidth = 3.0)
                scatter!(ax2, equilibria.stable[1], V(equilibria.stable[1], μ), color = CtpBlue, markersize = 30, strokewidth = 3.0)
                ax2.xticks = [domain[1], 0.1504721, equilibria.stable[1], domain[end]]
        else
                scatter!(ax1, equilibria.stable[1], f(equilibria.stable[1], μ), color = CtpBlue, markersize = 30, strokewidth = 3.0)
                scatter!(ax1, equilibria.unstable[1], f(equilibria.unstable[1], μ), color = CtpRed, markersize = 30, strokewidth = 3.0)
                scatter!(ax1, equilibria.stable[2], f(equilibria.stable[2], μ), color = CtpBlue, markersize = 30, strokewidth = 3.0)
                ax1.xticks = [domain[1], equilibria.stable[1], equilibria.unstable[1], equilibria.stable[2], domain[end]]
                scatter!(ax2, equilibria.stable[1], V(equilibria.stable[1], μ), color = CtpBlue, markersize = 30, strokewidth = 3.0)
                scatter!(ax2, equilibria.unstable[1], V(equilibria.unstable[1], μ), color = CtpRed, markersize = 30, strokewidth = 3.0)
                scatter!(ax2, equilibria.stable[2], V(equilibria.stable[2], μ), color = CtpBlue, markersize = 30, strokewidth = 3.0)
                ax2.xticks = [domain[1], equilibria.stable[1], equilibria.unstable[1], equilibria.stable[2], domain[end]]
        end
end

# Plot the vector field analog 
function plot_vector_analog()
        # Draw arrows to represent the analog vector field
        points = [-0.25, 0.25, 0.42, 0.75, 1.25]
        directions = [+1, -1, +1, +1, -1]
        arrows!(ax1, points, [0 for p in points], directions, [0 for p in points], arrowsize = 20, lengthscale = 0.1, linewidth = 4)

        # Loop over the points
        for point in points
                # Plot a dashed line from the function value at the point to the x-axes
                lines!(ax1, [point, point], [0.0, f(point, 0)], color = (:black,0.85), linewidth = 2.5, linestyle = :dash)
                # Plot the point
                scatter!(ax1, point, f(point, 0), color = :black, markersize = 20)
        end
end
