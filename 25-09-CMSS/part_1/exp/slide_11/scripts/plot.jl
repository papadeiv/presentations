"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Plot the non-autonomous solution and the parameter shift
function plot_solution(solution, timestep)
        # Create empty layouts for the figures
        include("./scripts/figs.jl")

        # Extract the components of the solution
        t = solution.time
        λ = solution.param
        u = solution.states
        
        # Plot the drift of the QSEs
        lines!(ax1, λ1, x1, color = :black, linewidth = 5.0)
        lines!(ax1, λ2, x2, color = :black, linewidth = 5.0)
        lines!(ax1, λ3, x3, color = :black, linewidth = 5.0, linestyle = :dash)

        # Plot the shift of the parameter
        lines!(ax2, t, λ, color = CtpBlue, linewidth = 5.0)

        # Plot the state of the system up until the current timestep
        lines!(ax1, λ[1:timestep], u[1:timestep], color = (CtpRed,0.85), linewidth = 5.0)
        scatter!(ax1, λ[timestep], u[timestep], color = CtpRed, markersize = 30, strokewidth = 3.0)

        # Plot the shift of the parameter value at the current timestep
        scatter!(ax2, t[timestep], λ[timestep], color = CtpBlue, markersize = 30, strokewidth = 3.0)
end
