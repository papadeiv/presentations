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
        sample_path = evolve_shifted_1d(f, g, η, x0, μf, δt=δt)
        t = sample_path.time
        μ = sample_path.parameter
        u = (sample_path.states)[1]

        # Convert the analysis of the non-autonomous drift into an ensemble problem
        ensemble = preprocess_solution(t, μ, u, width)
        tipping = ensemble.tipping_point
        Ne = length(ensemble.trajectories)
        Nt = length(ensemble.trajectories[1])

        # Plot the full timeseries
        plot_solution(t, u, tipping)

        # Loop over the ensemble's sample paths
        printstyled("Computing the variance across the sliding window's strides\n"; bold=true, underline=true, color=:light_blue)
        @showprogress for n in 1:Ne
                # Create empty layouts for the figures
                include("./scripts/figs.jl")

                # Plot the full timeseries
                plot_solution(t, u, tipping)

                # Compute the quasi-steady equilibrium in the windowed parameter range of the subseries 
                qse = [(get_equilibria(f, μc, domain=[-10,10])).stable[2] for μc in ensemble.parameters[n]] 
                
                # Extract the current solution from the ensemble and detrend it 
                detrended_solution = detrend(ensemble.trajectories[n], qse = qse)
                residuals = detrended_solution.residuals

                # Compute the variance of the residuals
                push!(time_ews, ensemble.timesteps[n][end])
                push!(var_ews, var(residuals))

                # Plot and timeseries and variance in the sliding window
                plot_window(ensemble.timesteps[n], time_ews, var_ews)
                savefig("slide_09/$n.png", fig1)
        end
end

# Execute the main
main()
