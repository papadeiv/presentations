"""
    Main script

Run this file to execute the simulation, analyse and plot the results.
"""

# Import the necessary packages and local modules
include("inc.jl")

# Import the simulation's scripts
include("./scripts/sim.jl")
include("./scripts/plot.jl")

# Define the main algorithm
function main()
        # Loop over the initial conditions
        @showprogress for n in 1:length(u0)
                # Solve and plot the IVP in phase space 
                solution = evolve_2d(f1, f2, η, η, μ0, u0[n]; δt=δt, Nt=Nt)
                plot_solution(solution.states, μ0)
        end

        # Export the figure
        savefig("slide_06.png", fig1)
end

# Execute the main
main()
