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
        # Solve the ensemble problem 
        ensemble = evolve_1d(f, η, μ, [x0], δt=δt, Nt=Nt, Ne=Ne)

        # Loop over the ensemble's sample paths
        printstyled("Computing the least-squares solutions across the ensemble\n"; bold=true, underline=true, color=:light_blue)
        @showprogress for n in 1:Ne
                # Extract the current solution from the ensemble and center it
                t = ensemble.time
                u = ensemble.states[n] .- x0

                # Solve the nonlinear least-squares problem to fit a local cubic potential
                coefficients = fit_potential(u, n_coeff=Nc, n_bins=Nb, noise=σ, optimiser=β, attempts=Na)
                push!(solutions, coefficients)

                # Perform postprocessing analysis on the solutions
                Vs = analyse(coefficients)

                # Only enter this condition for the first 100 particles of the ensemble
                if n < 100
                        # Plot the timeseries and the reconstructed (shifted) potential 
                        plot_solutions(t, u, Vs, n)
                end
        end

        # Export the solutions figure
        savefig("slide_09_1.png", fig1)

        # Plot and export the analysis figures
        plot_results(solutions, results)
        savefig("slide_09_2.png", fig3)
        savefig("slide_10.png", fig6)
        savefig("slide_11.png", fig14)
end

# Execute the main
main()
