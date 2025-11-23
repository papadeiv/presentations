"""
    Postprocessing script

In here we define the quantities related to the computation of EWSs from raw data.
"""

# Parameters of the scalar potential method
width = 0.150::Float64                      # Relative size of the sliding window

# Data structures for storing the results of the analysis
time_ews = Vector{Float64}()                # Timestep of the early-warning signal for system
var_ews = Vector{Float64}()                 # Variance early-warning signal for system

# Converts the non-stationary timeseries into an ensemble of subseries associated to the strides of a sliding window 
function preprocess_solution(timestamps, timeseries_slow, timeseries_fast, width)
        # Find the tipping point
        tipping = find_tipping(timeseries_fast)
        idx = tipping.index

        # Extract the subseries up to the tipping
        t = timestamps[1:idx] 
        μ = timeseries_slow[1:idx]
        u = timeseries_fast[1:idx]
        Nt = length(u)

        # Get the sliding window parameters
        window = get_window_parameters(Nt, width)
        Nw = window.size 
        Ns = window.strides

        # Convert the sliding window subseries into ensemble timeseries
        printstyled("Converting the truncated sample path to an ensemble of ", Ns," trajectories of ", Nw, " steps\n"; bold=true, underline=true, color=:light_blue)
        timesteps = [t[n:(n+Nw-1)] for n in 1:Ns] 
        parameters = [μ[n:(n+Nw-1)] for n in 1:Ns] 
        ensemble = [u[n:(n+Nw-1)] for n in 1:Ns] 

        # Export the parameters of the ensemble problem 
        return (
                tipping_point = idx,
                timesteps = timesteps,
                parameters = parameters,
                trajectories = ensemble 
               ) 
end
