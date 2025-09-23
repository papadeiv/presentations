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
        # Solve the stationary SDE
        solution = evolve_1d(f, η, μ, [x0], δt=δt, Nt=Nt, Ne=Ne)
        t = solution.time
        u = solution.states[1]

        #=
        # Plot and export the potential
        plot_potential(u, μ)
        savefig("slide_08_1.png", fig1)
        # Plot and export the stationary distribution
        plot_distribution(μ)
        savefig("slide_08_2.png", fig1)
        # Plot and export the timeseries and histogram
        =#
        plot_solution(t, u, μ)
        #savefig("slide_08_3.png", fig1)
        savefig("slide_08_4.png", fig2)
end

# Execute the main
main()
