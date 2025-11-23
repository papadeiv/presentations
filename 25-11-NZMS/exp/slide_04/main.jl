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

        # Extract the timesteps
        t = ensemble.time
        μ = ensemble.parameter

        # Loop over the ensemble trajectories
        @showprogress for n in 1:convert(Int64, Ne)
                # Extract the trajectory
                u = (ensemble.state)[n]

                # Find the tipping point
                tipping = find_tipping(u, check = 0.010, criterion = 0.050, verbose=false)

                # Compute the increase in variance EWS
                ews = compute_ews(u, μ, tipping.index)

                # Determine whether the EWS is good or bad
                if n == 1
                        global min_ews = ews.signal[end-1]
                        global bad_ews = ews.signal
                        global bad_μ = ews.parameter
                        global max_ews = ews.signal[end-1]
                        global good_ews = ews.signal
                        global good_μ = ews.parameter
                else
                        if ews.signal[end-1] < min_ews
                                min_ews = ews.signal[end-1]
                                bad_ews = ews.signal
                                bad_μ = ews.parameter
                        elseif ews.signal[end-1] > max_ews
                                max_ews = ews.signal[end-1]
                                good_ews = ews.signal
                                good_μ = ews.parameter
                        end
                end

                # Plot the timeseries and export the figure
                plot(ews)
        end

        # Highlight good and bad ews
        highlight(bad_μ, bad_ews, good_μ, good_ews)

        # Export the figure
        savefig("slide_04.png", fig1)
end

# Execute the main
main()
