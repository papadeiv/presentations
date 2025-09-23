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
        # Solve the slow-fast SDE 
        sample_path = evolve_shifted_1d(f, Λ, η, x0, μf; δt=δt)
        t = sample_path.time
        μ = sample_path.parameter
        u = (sample_path.states)[1]

        # Convert the analysis of the non-autonomous drift into an ensemble problem
        ensemble = preprocess_solution(μ, u, width)
        tipping = ensemble.tipping_point
        Ne = length(ensemble.trajectories)
        Nt = length(ensemble.trajectories[1])

        # Loop over the ensemble's sample paths
        printstyled("Computing the least-squares solutions across the ensemble\n"; bold=true, underline=true, color=:light_blue)
        @showprogress for n in 1:Ne
                # Compute the quasi-steady equilibrium in the windowed parameter range of the subseries 
                qse = [(get_equilibria(f, μc, domain=[-10,10])).stable[2] for μc in ensemble.timesteps[n]] 
                
                # Extract the current solution from the ensemble and detrend it 
                detrended_solution = detrend(ensemble.trajectories[n], qse = qse)
                residuals = detrended_solution.residuals

                # Solve the NLLS problem
                coefficients = fit_potential(residuals, n_coeff=Nc, noise=σ, optimiser=β, attempts=Na)
                push!(solutions, coefficients)

                # Compute the escape early-warning
                Vs = analyse(coefficients, ensemble.timesteps[end][end])
        end

        # Plot and export the ews timeseries
        plot_ews(t, u, tipping, results)
        savefig("slide_12.png", fig1)
end

# Execute the main
main()
