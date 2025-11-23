"""

"""

# Import the necessary packages and local modules
include("inc.jl")

# Import the simulation's scripts
include("./scripts/sim.jl")
include("./scripts/proc.jl")
include("./scripts/plot.jl")

# Define the main algorithm
function main()
        # Solve the ensemble problem 
        ensemble = evolve(f, η, Λ, x0, stepsize=dt, endparameter=μf, particles=Ne)

        # Extract the sample paths and its timesteps
        t = ensemble.time
        μ = ensemble.parameter
        u = (ensemble.state)[1]

        # Find the tipping point
        tipping = find_tipping(u, check = 0.010, criterion = 0.050)

        # Compute the increase in variance EWS
        ews = compute_ews(t, u, μ, tipping.index)

        # Plot the timeseries and export the figure
        plot(t, u, ews, tipping.index)
end

# Execute the main
main()
