"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Define symmetric position for printing the text
δx = 1.0
δy = 1.5

# Define the middle equilibrium
x3(μ) = (μ[4] - μ[2])/(μ[1] + μ[4] - μ[2] - μ[3])

# Look-up list of plot actions depending on the position of the parameter in the bifurcation set
plot_action = Dict(
                   1 => (t, u, j) -> begin
                           # Print text in the bifurcation set
                           j == 1 && text!(ax5, δx, δy, text = L"\textbf{coordination game}", fontsize = 25, align = (:center,:baseline))
                           # Plot the solution
                           lines!(ax1, t, u, linewidth = 4, color = u, colormap = [(CtpYellow,1.0), (CtpRed,1.0)], colorrange = (0,1))
                           # Plot the equilibria
                           j == Nx && lines!(ax1, [t[1], t[end]], [0.0, 0.0], linewidth = 6, color = :black)
                           j == Nx && lines!(ax1, [t[1], t[end]], [1.0, 1.0], linewidth = 6, color = :black)
                           j == Nx && lines!(ax1, [t[1], t[end]], [x3(A[1]) for T in [t[1], t[end]]], linewidth = 6, color = :black, linestyle = :dash)
                   end,
                   2 => (t, u, j) -> begin
                           # Print text in the bifurcation set
                           j == 1 && text!(ax5, -δx, δy, text = L"\textbf{dominant strategy}", fontsize = 25, align = (:center,:baseline))
                           # Plot the solution
                           lines!(ax2, t, u, linewidth = 4, color = u, colormap = [(CtpYellow,1.0), (CtpRed,1.0)], colorrange = (0,1))
                           # Plot the equilibria
                           j == Nx && lines!(ax2, [t[1], t[end]], [0.0, 0.0], linewidth = 6, color = :black)
                           j == Nx && lines!(ax2, [t[1], t[end]], [1.0, 1.0], linewidth = 6, color = :black, linestyle = :dash)
                   end,
                   3 => (t, u, j) -> begin
                           # Print text in the bifurcation set
                           j == 1 && text!(ax5, δx, -δy, text = L"\textbf{dominant strategy}", fontsize = 25, align = (:center,:baseline))
                           # Plot the solution
                           lines!(ax3, t, u, linewidth = 4, color = u, colormap = [(CtpYellow,1.0), (CtpRed,1.0)], colorrange = (0,1))
                           # Plot the equilibria
                           j == Nx && lines!(ax3, [t[1], t[end]], [0.0, 0.0], linewidth = 6, color = :black, linestyle = :dash)
                           j == Nx && lines!(ax3, [t[1], t[end]], [1.0, 1.0], linewidth = 6, color = :black)
                   end,
                   4 => (t, u, j) -> begin
                           # Print text in the bifurcation set
                           j == 1 && text!(ax5, -δx, -δy, text = L"\textbf{anti-coordination}", fontsize = 25, align = (:center,:baseline))
                           # Plot the solution
                           lines!(ax4, t, u, linewidth = 4, color = u, colormap = [(CtpYellow,1.0), (CtpRed,1.0)], colorrange = (0,1))
                           # Plot the equilibria
                           j == Nx && lines!(ax4, [t[1], t[end]], [0.0, 0.0], linewidth = 6, color = :black, linestyle = :dash)
                           j == Nx && lines!(ax4, [t[1], t[end]], [1.0, 1.0], linewidth = 6, color = :black, linestyle = :dash)
                           j == Nx && lines!(ax4, [t[1], t[end]], [x3(A[4]) for T in [t[1], t[end]]], linewidth = 6, color = :black)
                   end,
                  )

# Plot timeseries and bifurcation set
function plot_solutions(data, index)
        # Compute amd plot the position in the bifurcation set
        ɑ = A[index][1] - A[index][3] 
        β = A[index][4] - A[index][2]
        scatter!(ax5, ɑ, β, color = CtpMauve, markersize = 30, strokecolor = :black, strokewidth = 2)

        # Get the action related to the index
        action = plot_action[index] 

        # Split time and solutions from the data
        time = data[1] 
        solutions = data[2:end]

        # Loop over the initial conditions
        for n in 2:length(solutions)
                # Perform the plot action
                action(time, solutions[n], n)
        end
end
