"""
    Postprocessing script

Collection of quantities and functions used to postprocess and analyse the results of a simulation.
"""

# Data structures for storing the results
first_passage_time = Vector{Float64}()          # First passage times of the sample paths 

function compute_first_passage(solution)
        # Extract timesteps and states
        t = solution.time
        x = solution.states[:,1]
        y = solution.states[:,2]

        # Initialise the time index of first passage
        idx = 0::Int64

        # Loop over the realisations of the timeseries
        for n in 1:length(x)
                # Check first passage
                if sqrt(x[n]^2 + y[n]^2) < R 
                        idx = n
                        break
                end
        end

        return t[idx]
end
