"""
    Main script

Run this file to execute the simulation, analyse and plot the results.
"""

# Import the necessary packages and local modules
include("inc.jl")

# Import the simulation's scripts
include("./scripts/sim.jl")
include("./scripts/proc.jl")
include("./scripts/plot.jl")

# Define the main algorithm
function main()
        # Solve the slow-fast SDE
        sample_path = evolve_shifted_2d(f1, f2, g, η, η, x0, μf, δt=δt)
        t = sample_path.time
        μ = sample_path.parameter
        u = sample_path.states

        # Compute the scalar observables of the solution
        v, w = ψ.(u[:,1],u[:,2]), ϕ.(u[:,1],u[:,2])

        # Find the tipping points in the univariate timeseries and plot them 
        tipping = (find_tipping(u[:,1])).index            # x-component of the slow-fast solution u
        plot_solution(t, u[:,1], tipping, 1)
        tipping = (find_tipping(u[:,2])).index            # y-component of the slow-fast solution u
        plot_solution(t, u[:,2], tipping, 2)
        tipping = (find_tipping(v)).index                 # Scalar observable ψ of u
        plot_solution(t, v, tipping, 3)
        tipping = (find_tipping(w)).index                 # Scalar observable ϕ of u
        plot_solution(t, w, tipping, 4)

        # Export the figure
        savefig("slide_10_1.png", fig1)

        # Convert the analysis of the non-autonomous drift into an ensemble problem
        ensemble = preprocess_solution(t, μ, v, width)
        tipping = ensemble.tipping_point
        Ne = length(ensemble.trajectories)
        Nt = length(ensemble.trajectories[1])

        # Loop over the ensemble's sample paths
        printstyled("Computing the variance across the sliding window's strides\n"; bold=true, underline=true, color=:light_blue)
        @showprogress for n in 1:Ne
                # Extract the current solution from the ensemble and detrend it 
                detrended_solution = detrend(ensemble.trajectories[n], alg = "linear", timestamps = ensemble.timesteps[n])
                residuals = detrended_solution.residuals

                # Compute the variance of the residuals
                push!(time_ews, ensemble.timesteps[n][end])
                push!(var_ews, var(residuals))
        end

        # Plot and export the figure
        plot_solution(t, v, tipping, time_ews, var_ews)
        savefig("slide_10_2.png", fig5)
end

# Execute the main
main()
