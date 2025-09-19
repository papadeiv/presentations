"""
Dynamics utility functions associated to propagating a solution of a system of differential equations forward in time. 

Author: Davide Papapicco
Affil: U. of Auckland
Date: 21-08-2025
"""

#--------------------------#
#                          # 
#   evolve_1d_systems.jl   #                     
#                          #
#--------------------------#

"""
    evolve_1d(f, η, μ, u0; kwargs...)

Solves an IVP for an SDE in 1-dimension from initial condition `u0` with drift `f` and diffusion `η` at parameter value `μ`.
"""
function evolve_1d(f::Function, η::Function, μ, u0::Vector; δt=1e-2, saveat=δt, Nt=1000::Int64, Ne=1::Int64)
        # Compute the total time 
        T = δt*Nt

        # Deterministic dynamics 
        function drift!(dudt, u, μ, t)
                dudt[1] = f(u[1], μ) 
        end
        # Stochastic dynamics
        function diffusion!(dudt, u, μ, t)
                dudt[1] = η(u[1]) 
        end
      
        # Define the differential equation
        dynamics = SDEProblem(drift!, diffusion!, u0, (0.0, T), μ)

        # Convert it into an ensemble problem
        ensemble = EnsembleProblem(dynamics)

        # Solve the problem forward in time
        sol = solve(ensemble, EM(), dt=δt, verbose=false, EnsembleDistributed(), trajectories=Ne)

        # Extract the timepoints for plotting purposes
        time = sol[1].t
        Nt = length(time)

        # Extract the timeseries
        states = Vector{Vector{Float64}}()
        for n in 1:Ne
                push!(states, [(sol[n].u)[t][1] for t in 1:Nt])
        end

        # Return the solutions and their timestamps
        return (
                time = time, 
                states = states
               )
end

"""
    evolve_shifted_1d(f, Λ, η, u0, T; kwargs...)

Solves a non-autonomous IVP in 1-d with drift `f`, shift `Λ` and diffusion `η` starting from initial condition `u0` in time interval `T`.
"""
function evolve_shifted_1d(f::Function, Λ::Function, η::Function, u0::Vector, T::Vector; Nt=1000::Int64, saveat=nothing)
        # Compute the timestep
        δt = (T[end]-T[1])/Nt

        # Compute the export timestep
        Δt = 0.00::Float64
        if saveat == nothing
                Δt = δt
        else
                Δt = saveat 
        end

        # Deterministic dynamics 
        function drift!(dudt, u, λ, t)
                dudt[1] = f(u[1], u[2])
                dudt[2] = λ(t)
        end
        # Stochastic dynamics
        function diffusion!(dudt, u, λ, t)
                dudt[1] = η(u[1])
                dudt[2] = 0 
        end
        
        # Define the differential equation
        dynamics = SDEProblem(drift!, diffusion!, u0, (T[1], T[end]), Λ)

        # Solve the SDE forward in time
        sol = solve(dynamics, EM(), dt=δt, verbose=false, saveat=Δt)

        # Extract the timestamps
        time = sol.t
        Nt = length(time)

        # Extract the solution and the time evolution
        states = [(sol.u)[t][1] for t in 1:Nt]
        param = [(sol.u)[t][2] for t in 1:Nt]

        # Return the solutions and their timestamps
        return (
                time = time, 
                param = param, 
                states = states
               )
end

"""
    evolve_shifted_1d(f, Λ, η, u0, T; kwargs...)

Overload of the above function evolving an ensemble of non-autonomous SDEs with linear shift `Λ(t) = μ0 + εt` between parameter values `μ0 = u0[2]` and `μf` rather than a between two time instants.
"""
function evolve_shifted_1d(f::Function, Λ::Function, η::Function, u0::Vector, μf::Float64; δt=1e-2, saveat=δt, Ne=1::Int64)
        # Specify the simulation endtime and number of timesteps according to the parameter range
        T = (μf-u0[2])/Λ(0)
        Nt = T/δt

        # Deterministic dynamics 
        function drift!(dudt, u, μ, t)
                dudt[1] = f(u[1], u[2])
                dudt[2] = Λ(u[2])
        end
        # Stochastic dynamics
        function diffusion!(dudt, u, μ, t)
                dudt[1] = η(u[1])
                dudt[2] = 0 
        end
        
        # Define the differential equation
        dynamics = SDEProblem(drift!, diffusion!, u0, (0.0, T))

        # Convert it into an ensemble problem
        ensemble = EnsembleProblem(dynamics)

        # Solve the problem forward in time
        sol = solve(ensemble, EM(), dt=δt, verbose=false, EnsembleDistributed(), trajectories=Ne)

        # Extract the timestamps and parameter values
        time = sol[1].t
        Nt = length(time)
        param = [(sol[1].u)[t][2] for t in 1:Nt]

        # Extract the timeseries
        states = Vector{Vector{Float64}}() 
        for n in 1:Ne
                push!(states, [(sol[n].u)[t][1] for t in 1:Nt])
        end

        # Return the solutions and their timestamps
        return (
                time = time,
                parameter = param,
                states = states
               )
end
