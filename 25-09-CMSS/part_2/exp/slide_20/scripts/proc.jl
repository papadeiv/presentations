"""
    Postprocessing script

In here we define the quantities related to the computation of EWSs from raw data.
"""

# Parameters of the scalar potential method
width = 0.450::Float64                      # Relative size of the sliding window
Nc = convert(Int64, 3e0)                    # Solution space dim. of the method 
Na =  convert(Int64, 1e4)                   # Number of attempts per guess 
β = 1e-2                                    # Std of the guess perturbation 

# Scalar potential of the conservative system 
U(x, μ) = μ*x + x^2 - x^3 + (1/5)*(x^4)     # Potential (ground truth)
Uxx(x, μ) = 2 - 6*x + (12/5)*(x^2)          # Second derivative ( == Jacobian) 

# Reconstructed dynamics 
V(x,c) = c[1]*x + c[2]*(x^2) + c[3]*(x^3)   # Potential
Vxx(x,c) = 2*c[2] + 6*c[3]*x                # Second derivative

# Unnormalised stationary probability distribution
p(x,c) = exp(-(1.0::Float64/D)*(V(x,c)))

# Data structures
solutions = Vector{Vector{Float64}}()           # Solutions of the inference method 
results = Vector{Vector{Float64}}()             # Statistical distribution over the ensemble

# Converts the non-stationary timeseries into an ensemble of subseries associated to the strides of a sliding window 
function preprocess_solution(timestamps, timeseries, width)
        # Find the tipping point
        tipping = find_tipping(timeseries)
        idx = tipping.index

        # Extract the subseries up to the tipping
        t = timestamps[1:idx] 
        u = timeseries[1:idx]
        Nt = length(u)

        # Get the sliding window parameters
        window = get_window_parameters(Nt, width)
        Nw = window.size 
        Ns = window.strides

        # Convert the sliding window subseries into ensemble timeseries
        printstyled("Converting the truncated sample path to an ensemble of ", Ns," trajectories of ", Nw, " steps\n"; bold=true, underline=true, color=:light_blue)
        timesteps = [t[n:(n+Nw-1)] for n in 1:Ns] 
        ensemble = [u[n:(n+Nw-1)] for n in 1:Ns] 

        # Export the parameters of the ensemble problem 
        return (
                tipping_point = idx,
                timesteps = timesteps,
                trajectories = ensemble 
               ) 
end

function shift_potential(U::Function, x0, μ, c)
        # Compute the stable equilibrium (center of the shift)
        xs = +(1/(3*c[3]))*(sqrt((c[2])^2 - 3*c[1]*c[3]) - c[2])

        # Compute the shifts
        δx = x0 - xs 
        δy = U(x0, μ) - (Polynomial([0.0; c]))(xs)

        # Define the shifted potential
        Vs(x) = δy + c[1]*(x - δx) + c[2]*(x - δx)^2 + c[3]*(x - δx)^3

        return xs, Vs
end

# Numerical error of the potential reconstruction (trapezoid rule on L2-norm)
function get_error(Vs, μ; Nh=1000)
        # Create uniform partition of the domain of integration
        domain = LinRange(equilibria.unstable[1], equilibria.stable[2], Nh)
        dx = domain[2] - domain[1] 

        # Define the integrand
        E = [(U(x, μ) - Vs(x))^2 for x in domain]

        return sqrt(dx*(sum(E) - 0.5*(E[1]+E[end])))
end

function analyse(solutions, parameter)
        # Reconstruct a shifted potential to match the ground truth (for error and plotting purposes)
        xs, Vs = shift_potential(U, x0[1], parameter, solutions)

        # Compute estimated stable and unstable equilibria of the cubic
        xs = +(1/(3*solutions[3]))*(sqrt((solutions[2])^2 - 3*solutions[1]*solutions[3]) - solutions[2])
        xu = -(1/(3*solutions[3]))*(sqrt((solutions[2])^2 - 3*solutions[1]*solutions[3]) + solutions[2])

        # Define empty vector
        analysis = Float64[]

        # Compute the ews
        push!(analysis, exp(-abs(V(xu, solutions) - V(xs, solutions))))

        # Compute the approximation error
        push!(analysis, get_error(Vs, parameter))

        # Update the results vector
        push!(results, analysis)

        # Return the shifted potential (for plotting)
        return Vs 
end
