"""
    Postprocessing script

In here we define the quantities related to the computation of EWSs from raw data.
"""

# Number of steps indicating the transient lapse of the critical transition
transition = 400::Int64

# Size of the sliding window (as a fraction of the total length of the timeseries)
width = 0.300::Float64

# Compute the variance of a timeseries on sliding window
function compute_ews(timestep, timeseries, parameter, tipping_point)
        # Compute the total number of timesteps
        Nt = length(timestep[1:tipping_point])

        # Assemble a sliding window
        window = build_window(Nt, width)
        Nw = window.size
        Ns = window.strides

        # Define array to store the signal
        ews = Vector{Float64}(undef, Ns)

        # Loop over the window strides
        for n in 1:Ns
                # Detrend the windowed subseries
                timeseries_detrended = detrend(timeseries[n:(n+Nw)]; alg = "exact", qse = parameter[n:(n+Nw)])

                # Compute the variance of the residuals
                ews[n] = var(timeseries_detrended.residuals)
        end

        return (
                time = timestep[Nw:(Ns+Nw-1)],
                signal = ews 
               )
end

function evolve_may(dt, cT)
        # Define May's model
        σ = 0.1        # Level of (additive) noise
        ε = 0.01       # Timescale of the slow ramping of the forcing parameter
        r = 1.0        # Growth rate
        k = 10.0       # Carrying capacity
        Vh = 1.0       # Half-grazing biomass

        # Define the dynamical system 
        f(x, μ) = r*x*(1.0-(1.0/k)*x) - μ*((x^2)/((x^2) + (Vh^2)))
        g(x) = ε
        η(x) = σ

        # Initial condition 
        V0 = 8.0       # Vegetation biomass (state)
        c0 = 1.5       # Grazing rate (forcing parameter)
        x0 = [V0, c0]

        # Solve May's system
        May = evolve(f, η, g, x0, endparameter=cT, stepsize=dt)
        return May
end
