"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

function plot_solution(t, nonlinear, closeup, linear)
       # Extract the x and y component of the solutions
        x = nonlinear[:,1]
        y = nonlinear[:,2]
        x_close = closeup[:,1]
        y_close = closeup[:,2]
        u = linear[:,1]
        v = linear[:,2]

        # Plot the nonlinear and linearised trajectory in phase space
        lines!(ax1, x, y, color = (CtpGray,0.15), linewidth = 3.0)
        lines!(ax2, x_close, y_close, color = (CtpGray,0.15), linewidth = 3.0)
        lines!(ax3, u, v, color = (CtpGray,0.15), linewidth = 3.0)

        # Plot a circle around the saddle equilibria marking the neighbourhood
        lines!(ax2, Circle(Point2f(1, 0), 0.35), color = :black, linewidth = 5.0, linestyle = :dash)
        # Plot the stable and unstable manifolds
        stable(z) = 0.0
        unstable(z) = -2*(z - 1) 
        unstable_linearised(z) = -2*z 
        domain = collect(LinRange(0.25,1.75,1000))
        domain_linearised = collect(LinRange(-3,3,1000))
        lines!(ax2, domain, [stable(p) for p in domain], color = CtpBlue, linewidth = 5.0)
        lines!(ax3, domain_linearised, [stable(p) for p in domain_linearised], color = CtpBlue, linewidth = 5.0)
        lines!(ax2, domain, [unstable(p) for p in domain], color = CtpRed, linewidth = 5.0)
        lines!(ax3, domain_linearised, [unstable_linearised(p) for p in domain_linearised], color = CtpRed, linewidth = 5.0)
        # Plot the stable and unstable eigenvectors
        v_x = [1, -1, 1, -1]
        v_y = [0, 0, -2, 2]
        arrows!(ax2, [1 for n in 1:2], [0 for n in 1:2], v_x[1:2], v_y[1:2], color = CtpBlue, arrowsize = 30, lengthscale = 0.1, linewidth = 5)
        arrows!(ax3, [0 for n in 1:2], [0 for n in 1:2], v_x[1:2], v_y[1:2], color = CtpBlue, arrowsize = 30, lengthscale = 0.5, linewidth = 5)
        arrows!(ax2, [1 for n in 3:4], [0 for n in 3:4], v_x[3:4], v_y[3:4], color = CtpRed, arrowsize = 30, lengthscale = 0.1, linewidth = 5)
        arrows!(ax3, [0 for n in 3:4], [0 for n in 3:4], v_x[3:4], v_y[3:4], color = CtpRed, arrowsize = 30, lengthscale = 0.5, linewidth = 5)

        # Plot the equilibria in all plots
        scatter!(ax1, 0, 0, color = CtpRed, markersize = 30, strokewidth = 3.0)
        scatter!(ax1, 0, 1, color = :black, markersize = 30, strokewidth = 3.0, marker = :star5)
        scatter!(ax1, 1, 0, color = CtpYellow, markersize = 30, strokewidth = 3.0)
        scatter!(ax2, 1, 0, color = CtpYellow, markersize = 30, strokewidth = 3.0)
        scatter!(ax3, 0, 0, color = CtpYellow, markersize = 30, strokewidth = 3.0)
end
