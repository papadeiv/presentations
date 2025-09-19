"""
    ?

???
"""

# Import the necessary packages and local modules
include("inc.jl")

# Import the simulation's scripts
include("./scripts/sim.jl")
include("./scripts/plot.jl")

# Define the main algorithm
function main()
        # Solve the slow-fast SDE 
        sample_path = evolve_shifted_1d(f, g, η, x0, μf, δt=δt)
        t = sample_path.time
        μ = sample_path.parameter
        u = (sample_path.states)[1]

        # Identify the instant of tipping in the solution
        tipping = find_tipping(u)
        idx = tipping.index

        # Plot and export the timeseries
        plot_tip(t, u, idx)
        savefig("slide_02.png", fig1)
end

# Execute the main
main()
