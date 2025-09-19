"""
    ?

???
"""

# Import the necessary packages and local modules
include("inc.jl")

# Import the simulation's scripts
include("./scripts/sim.jl")
include("./scripts/proc.jl")
include("./scripts/plot.jl")

# Define the main algorithm
function main()
        # Loop over the initial conditions
        for n in 1:length(u0)
                # Solve the IVP for the current IC
                solution = evolve_2d(f, g, η, η, μ, u0[n]; δt=δt, Nt=Nt)
                global t = solution.time
                u = solution.states
                push!(solutions, u)

                # Plot the phase space trajectory and timeseries
                plot_solution(t, u)
        end

        # Solve the IVP along the x-nullcline and plot the solution
        solution = evolve_2d(f, g, η, η, μ, [0.0, -0.5]; δt=δt, Nt=Nt)

        # Plot two highlighted trajectories
        plot_highlight(t, solution.states, CtpBlue)
        plot_highlight(t, solutions[64], CtpRed)

        # Export the figure
        savefig("slide_07_2.png", fig1)
        savefig("slide_07_1.png", fig2)
end

# Execute the main
main()
