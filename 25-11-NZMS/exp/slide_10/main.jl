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
        # Parameter sweep 
        for m in 1:length(μ)
                # Define the initial condition 
                equilibria = get_equilibria(f, μ[m], domain=[-10,10])
                x0 = [equilibria.stable[1], μ[m]]

                # Solve the ensemble problem 
                ensemble = evolve(f, η, Λ, x0, stepsize=dt, steps=Nt, particles=Ne)

                # Loop over the ensemble's sample paths
                printstyled("μ=$(μ[m]): solving the unweighted least-squares problems\n"; bold=true, underline=true, color=:light_blue)
                @showprogress for n in 1:length(ensemble.state)
                        # Check for tipping
                        tipping = find_tipping(ensemble.state[n], check = 0.010, criterion = 0.010, verbose=false)
                        tipping.check && (global Nx += 1)

                        # Extract the trajectory until the tipping and center it 
                        u = (ensemble.state[n])[1:tipping.index] .- sqrt(-μ[m])

                        # Solve the nonlinear least-squares problem to fit a cubic potential
                        solution = fit_potential(u, noise=σ, transformation=[1.0,0.0,0.0], optimiser=β, attempts=Na)
                        push!(solutions, solution.fit)

                        # Perform postprocessing analysis on the solutions
                        Vs = analyse(solution.fit, μ[m])
                end

                # Export the csv file for the unweigthed case and empty the arrays
                export_data(μ[m], 1)
                empty!(results)
                empty!(solutions)

                # Loop over the ensemble's sample paths
                printstyled("μ=$(μ[m]): solving the weighted least-squares problems\n"; bold=true, underline=true, color=:light_blue)
                @showprogress for n in 1:length(ensemble.state)
                        # Check for tipping
                        tipping = find_tipping(ensemble.state[n], check = 0.010, criterion = 0.010, verbose=false)
                        tipping.check && (global Nx += 1)

                        # Extract the trajectory until the tipping and center it 
                        u = (ensemble.state[n])[1:tipping.index] .- sqrt(-μ[m])

                        # Solve the nonlinear least-squares problem to fit a cubic potential
                        solution = fit_potential(u, noise=σ, transformation=[0.0,1.0,8.0], optimiser=β, attempts=Na)
                        push!(solutions, solution.fit)

                        # Perform postprocessing analysis on the solutions
                        Vs = analyse(solution.fit, μ[m])
                end

                # Export the csv file for the unweigthed case and empty the arrays
                export_data(μ[m], 2)
                empty!(results)
                empty!(solutions)
        end

        # Plot the figure
        plot_ews()
end

# Execute the main
main()
