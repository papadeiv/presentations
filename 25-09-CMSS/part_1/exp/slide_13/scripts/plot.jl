"""
    Plotting script

Collection of all the functions used to generate the plots of the simulations.
"""

# Create empty layouts for the figures
include("./figs.jl")

# Plot the solution for a given initial condition 
function plot_solution(solution)
        # Extract the components of the solution
        t = solution.time
        λ = solution.param
        x = solution.states[:,1]
        y = solution.states[:,2]

        # Plot the time-evolution
        lines!(ax1, t, x, y, linewidth = 1.0, color = y, colormap = [(CtpYellow,0.15),(CtpRed,0.15)], colorrange = (-10,1))
end 

# Plot the pullback attractor
function plot_pb_attractor(solution)
        # Extract the components of the solution
        t = solution.time
        λ = solution.param

        # Loop over the timestamps 
        for n in 1:length(t) 
                # Compute all equilibria at current parameter value
                equilibria = get_equilibria(f1, f2, λ[n])

                # Split the equilibria into stable and unstable ones
                stable = equilibria.stable
                unstable = equilibria.unstable 

                # Check if you are in the region of bistability
                if length(stable) == 2 
                        push!(x1, stable[1][1])
                        push!(y1, stable[1][2])
                        push!(t1, t[n])
                        push!(x2, stable[2][1])
                        push!(y2, stable[2][1])
                        push!(t2, t[n])
                else
                        push!(x1, stable[1][1])
                        push!(y1, stable[1][2])
                        push!(t1, t[n])
                end

                # Check if the unstable equilibrium exists
                if length(unstable) == 1
                        push!(x3, unstable[1][1])
                        push!(y3, unstable[1][2])
                        push!(t3, t[n])
                end
        end

        # Plot the equilibria
        lines!(ax1, t1, x1, y1, color = CtpBlue, linewidth = 3.0)
        lines!(ax1, t2, x2, y2, color = CtpBlue, linewidth = 3.0)
        lines!(ax1, t3, x3, y3, color = CtpRed, linewidth = 3.0)
end
