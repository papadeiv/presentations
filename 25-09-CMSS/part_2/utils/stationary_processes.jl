"""
Analysis utilities for stationary stochastic processes. 

Author: Davide Papapicco
Affil: U. of Auckland
Date: 03-09-2025
"""

#-----------------------------#
#                             # 
#   stationary_processes.jl   #                     
#                             #
#-----------------------------#

function fit_distribution(u; interval = nothing, n_bins = 200::Int64)
        # Get the range of values of the distribution
        if interval == nothing
                global u_min = u[argmin(u)]
                global u_max = u[argmax(u)]
                global range = u_max - u_min
        else
                global u_min = interval[1]
                global u_max = interval[end]
                global range = interval[end] - interval[1] 
        end

        # Define the edges of the bins of the histogram
        x = LinRange(u_min - range*0.05, u_max + range*0.05, n_bins)

        # Derive the center-points for the locations of the bins in the plot
        bins = [(x[n+1]+x[n])/2 for n in 1:(length(x)-1)]

        # Fit the histogram through the defined bins
        hist = StatsBase.fit(Histogram, u, x)

        # Normalise the histrogram to get an empirical pdf
        pdf = (LinearAlgebra.normalize(hist, mode = :pdf)).weights
                
        # Export the data
        return bins, pdf, LinearAlgebra.norm(hist)
end

function get_normalisation_constant(f::Function, parameters, domain; accuracy=1e-8)
        # Define the integral problem over the domain
        if parameters == nothing
                global integral = IntegralProblem(f, domain)
        else
                global integral = IntegralProblem(f, domain, parameters)
        end
        # Solve the definite integral by using adaptive Gauss-Kronrod quadrature
        quadrature = solve(integral, QuadGKJL(); maxiters=10000, reltol=accuracy, abstol=accuracy)
        # Return the approximation
        return 1.0::Float64/(quadrature.u)
end

function get_normalisation_constant(f::Function, parameters; accuracy=1e-8)
        # Compute the location of the local minima and maxima
        μ = parameters
        xs = +(1/(3*μ[3]))*(sqrt((μ[2])^2 - 3*μ[1]*μ[3]) - μ[2])
        xu = -(1/(3*μ[3]))*(sqrt((μ[2])^2 - 3*μ[1]*μ[3]) + μ[2])

        # Define the integration interval
        I = (-Inf,Inf)
        if xs > xu
                I = (xu, +Inf) 
        else
                I = (-Inf, xu) 
        end

        # Define the integral problem over the domain
        if parameters == nothing
                global integral = IntegralProblem(f, I)
        else
                global integral = IntegralProblem(f, I, parameters)
        end
        # Solve the definite integral by using adaptive Gauss-Kronrod quadrature
        quadrature = solve(integral, QuadGKJL(); maxiters=10000, reltol=accuracy, abstol=accuracy)
        # Return the approximation
        return 1.0::Float64/(quadrature.u)
end

function invert_equilibrium_distribution(bins, distribution, noise::Float64; N = nothing)
        # Compute the diffusion coefficient
        D = (noise^2)/2

        # Filter out the 0-valued entries in the distribution
        idx = findall(x -> x > 0.0, distribution)
        ys = [distribution[n] for n in idx]
        xs = [bins[n] for n in idx]

        # Define the normalisation constant based on user input
        if N == nothing
                # Assumption of a stationary OUP
                N=1/sqrt(2*pi*D)
        end

        # Compute the distribution on the potential using the stationarity assumption
        Vs = -D.*log.(ys./N)

        # Return the filtered datapoints and their location
        return xs, Vs
end

function approximate_potential(data_x, data_f; degree=3::Int64)
        interpolant = Polynomials.fit(data_x, data_f, degree)
        return interpolant
end

function fit_potential(timeseries; n_coeff=3, n_bins=nothing, noise=nothing, initial_guess=nothing, optimiser=1e-2, attempts=1000, verbose = false)
        # Number of coefficients for the non-linear least-squares problem
        Nc = n_coeff

        # Number of bins for the histogram
        if n_bins == nothing
                n_bins = convert(Int64, floor(0.02*length(timeseries)))
        end
        Nb = n_bins

        # Additive noise in the SDE
        if noise == nothing
                noise = std(timeseries)
        end
        σ = noise

        # Noise in the optimiser's steps
        β = optimiser

        # Fit an empirical distribution to the timeseries data
        bins, hist = fit_distribution(timeseries, n_bins=Nb+1)

        # Initial guess for non-linear 0-problem 
        if initial_guess == nothing
                xs, Vs = invert_equilibrium_distribution(bins, hist, σ)
                initial_guess = (approximate_potential(xs, Vs, degree=Nc).coeffs[2:(Nc+1)])
        end

        # Define the stochastic diffusion
        D = (σ^2)/2.0::Float64

        # Compute a shift for the potential {c0} that sets V(xs)=0 to avoid numerical cancellation
        xs(μ) = (1/(3*μ[3]))*(sqrt((μ[2])^2 - 3*μ[1]*μ[3]) - μ[2])
        c0(μ) = - μ[1]*xs(μ) - μ[2]*(xs(μ))^2 - μ[3]*(xs(μ))^3

        # Define an arbitrary cubic with the the above constraint on {c0}
        V(x, μ) = c0(μ) + μ[1]*x + μ[2]*(x^2) + μ[3]*(x^3)
        # Define the unnormalised pdf as an exponential of the abritrary cubic
        f(x, μ) = exp(-(1.0::Float64/D)*(V(x, μ)))

        # Define the normalisation constant as a function of the 4 parameters
        N(μ) = get_normalisation_constant(f, μ)

        # Define the target of the optimisation problem: normalised pdf
        p(x, μ) = N(μ)*exp.(-(1.0::Float64/D).*(c0(μ) .+ μ[1]*x .+ μ[2]*(x.^2) .+ μ[3]*(x.^3)))

        # Define the lower and upper bounds for the coefficients
        lower = [-45.0, -25.0, -40.0] 
        upper = [45.0, 25.0, 40.0]
        
        # First attempt to solve the non-linear least-squares problem
        try
                solution = curve_fit(p, bins, hist, initial_guess, lower=lower, upper=upper).param
                return solution
        catch e
                if isa(e, ArgumentError) && (
                                             occursin("matrix contains Infs or NaNs", e.msg) ||
                                             occursin("Initial guess must be within bounds", e.msg)
                                            )
                        # No print
                else
                        rethrow(e)
                end
        end

        # Perturbed attempts
        tries = 0
        while tries < attempts
                try
                        # Perturb the initial guess
                        perturbed_guess = initial_guess + β.*randn(Nc)
                        # Attempt to solve the nonlinear problem
                        solution = curve_fit(p, bins, hist, perturbed_guess, lower=lower, upper=upper).param
                        return solution
                catch e
                        if isa(e, ArgumentError) && (
                                                     occursin("matrix contains Infs or NaNs", e.msg) ||
                                                     occursin("Initial guess must be within bounds", e.msg)
                                                    )
                                tries += 1
                        else
                                rethrow(e)
                        end
                end
        end

        # Return the linear solution
        if verbose
                debug("Curve fitting failed after $(tries) attempts.")
        end
        return initial_guess
end


