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

        # Plot and export the timeseries alone
        plot_timeseries(t, u)
        savefig("slide_03_1.png", fig1)

        # Add and export the location of the empirical tipping point
        plot_tipping(t[(find_tipping(u)).index])
        savefig("slide_03_2.png", fig1)
        
        # Add and export the location of the real tipping point
        plot_bifurcation(t, μ)
        savefig("slide_03_3.png", fig1)
        
        # Add and export the bifurcation diagram
        plot_bif_diag(t, μ)
        savefig("slide_03_4.png", fig1)
end

# Execute the main
main()
