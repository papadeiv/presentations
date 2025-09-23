"""
Dynamics utility functions associated to propagating a solution of a system of differential equations forward in time. 

Author: Davide Papapicco
Affil: U. of Auckland
Date: 21-08-2025
"""

#--------------------------#
#                          # 
#   evolve_2d_systems.jl   #                     
#                          #
#--------------------------#

function evolve_2d(f1::Function, f2::Function, η1::Function, η2::Function, μ::Float64, u0::Vector{Float64}; δt=1e-2, Nt=1000::Int64)
        # Compute the total time 
        T = δt*Nt

        # Deterministic dynamics 
        function drift!(dudt, u, μ, t)
                dudt[1] = f1(u[1], u[2], μ[1])
                dudt[2] = f2(u[1], u[2], μ[1])
        end
        # Stochastic dynamics
        function diffusion!(dudt, u, μ, t)
                dudt[1] = η1(u[1], u[2])
                dudt[2] = η2(u[1], u[2])
        end
        
        # Define the differential equation
        dynamics = SDEProblem(drift!, diffusion!, u0, (0.0, T), μ)

        # Solve the SDE forward in time
        sol = solve(dynamics, EM(), dt=δt, verbose=false)

        # Extract the solution and timestamps
        time = sol.t
        Nt = length(time)
        u1 = [(sol.u)[t][1] for t in 1:Nt]
        u2 = [(sol.u)[t][2] for t in 1:Nt]
        states = hcat(u1, u2)

        # Return the solutions and their timestamps
        return (
                time = time, 
                states = states
               )
end

function evolve_shifted_2d(f1::Function, f2::Function, Λ::Function, η1::Function, η2::Function, u0, T; Nt=1000::Int64, saveat=nothing)
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
                dudt[1] = f1(u[1], u[2], u[3])
                dudt[2] = f2(u[1], u[2], u[3])
                dudt[3] = λ(t)
        end
        # Stochastic dynamics
        function diffusion!(dudt, u, λ, t)
                dudt[1] = η1(u[1], u[1])
                dudt[2] = η2(u[1], u[1])
                dudt[3] = 0 
        end
        
        # Define the differential equation
        dynamics = SDEProblem(drift!, diffusion!, u0, (T[1], T[end]), Λ)

        # Solve the SDE forward in time
        sol = solve(dynamics, EM(), dt=δt, verbose=false, saveat=Δt)

        # Extract the timestamps
        time = sol.t
        Nt = length(time)

        # Extract the solution and the time evolution
        param = [(sol.u)[t][3] for t in 1:Nt]
        u1 = [(sol.u)[t][1] for t in 1:Nt]
        u2 = [(sol.u)[t][2] for t in 1:Nt]
        states = hcat(u1, u2)

        # Return the solutions and their timestamps
        return (
                time = time, 
                param = param, 
                states = states
               )
end

function evolve_shifted_2d(f1::Function, f2::Function, Λ::Function, η1::Function, η2::Function, u0::Vector, μf::Float64; δt=1e-2, saveat=δt, Ne=1::Int64)
        # Specify the simulation endtime and number of timesteps according to the parameter range
        T = (μf-u0[3])/Λ(0)
        Nt = T/δt

        # Deterministic dynamics 
        function drift!(dudt, u, λ, t)
                dudt[1] = f1(u[1], u[2], u[3])
                dudt[2] = f2(u[1], u[2], u[3])
                dudt[3] = λ(t)
        end
        # Stochastic dynamics
        function diffusion!(dudt, u, λ, t)
                dudt[1] = η1(u[1], u[2])
                dudt[2] = η2(u[1], u[2])
                dudt[3] = 0 
        end
       
        # Define the differential equation
        dynamics = SDEProblem(drift!, diffusion!, u0, (0.0, T), Λ)

        # Solve the SDE forward in time
        sol = solve(dynamics, EM(), dt=δt, verbose=false, saveat=saveat)

        # Extract the timestamps
        time = sol.t
        Nt = length(time)

        # Extract the solution and the time evolution
        param = [(sol.u)[t][3] for t in 1:Nt]
        u1 = [(sol.u)[t][1] for t in 1:Nt]
        u2 = [(sol.u)[t][2] for t in 1:Nt]
        states = hcat(u1, u2)

        # Return the solutions and their timestamps
        return (
                time = time,
                parameter = param,
                states = states
               )
end
