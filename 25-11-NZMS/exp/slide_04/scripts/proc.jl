"""
    Postprocessing script

In here we define the quantities related to the computation of EWSs from raw data.
"""

# Size of the sliding window (as a fraction of the total length of the timeseries)
width = 0.250::Float64

# Compute the variance of a timeseries on sliding window
function compute_ews(timeseries, parameter, tipping_point)
        # Compute the total number of timesteps
        Nt = length(parameter[1:tipping_point])

        # Assemble a sliding window
        window = build_window(Nt, width)
        Nw = window.size
        Ns = window.strides

        # Define array to store the signal
        ews = Vector{Float64}(undef, Ns)

        # Loop over the window strides
        for n in 1:(Ns-1)
                # Detrend the windowed subseries
                timeseries_detrended = detrend(timeseries[n:(n+Nw)]; alg = "exact", qse = sqrt.(.-parameter[n:(n+Nw)]))

                # Compute the variance of the residuals
                ews[n] = var(timeseries_detrended.residuals)
        end

        return (
                parameter = parameter[Nw:(Ns+Nw-1)],
                signal = ews 
               )
end
