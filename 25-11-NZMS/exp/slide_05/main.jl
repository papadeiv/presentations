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
        # Solve the ensemble problem 
        ensemble = evolve(f, η, Λ, x0, stepsize=dt, timerange=T, particles=Ne)

        # Extract the timesteps
        t = ensemble.time
        μ = ensemble.parameter

        # Loop over the ensemble trajectories
        @showprogress for n in 1:convert(Int64, Ne)
                # Extract the trajectory
                u = (ensemble.state)[n]

                # Plot the trajectory
                plot(t, u, Y)
        end

        # Plot the paths and actions 
        plot(Y, T)

        # Export the figure
        savefig("slide_05.png", fig1)
end

# Execute the main
main()
