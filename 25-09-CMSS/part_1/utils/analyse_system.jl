"""
Dynamics utility functions to compute the typical analytical properties of dynamical systems (equilibria, spectrum etc...).

Author: Davide Papapicco
Affil: U. of Auckland
Date: 21-08-2025
"""

#-----------------------#
#                       # 
#   analyse_system.jl   #                     
#                       #
#-----------------------#

"""
    get_equilibria(f, μ; domain)

Given a vector field `f` and its bifurcation parameter `μ` find all its equilibria and their stability.
Detailed description.
"""
function get_equilibria(f::Function, μ::Float64; domain=[-Inf,Inf])
        # Reduce the parameter dependent dynamics to a 1D scalar function
        F(x) = f(x, μ)

        # Find the zeros of the function in the specified interval
        equilibria = find_zeros(F, domain[1], domain[2])

        # Define empty arrays to separate stable from unstable equilibria
        stable = Float64[]
        unstable = Float64[]

        # Loop over the equilibria 
        for eq in equilibria
                # Compute the Jacobian at the equilibrium
                stability = ForwardDiff.derivative(F,eq)
                # Determine the stability by checking the sign 
                if stability < 0
                        push!(stable, eq)
                else
                        push!(unstable, eq)
                end
        end

        # Return all the equilibria 
        return (
                stable = stable,
                unstable = unstable
               ) 
end

"""
    get_equilibria(f; domain)

Overload of `get_equilibria` to find the roots of a vector field `f` that does not have an explicit dependence on the bifurcation parameter.
Detailed description.
"""
function get_equilibria(f::Function; domain=[-Inf,Inf])
        # Find the zeros of the function in the specified interval
        equilibria = find_zeros(f, domain[1], domain[2])

        # Define empty arrays to separate stable from unstable equilibria
        stable = Float64[]
        unstable = Float64[]

        # Loop over the equilibria 
        for eq in equilibria
                # Compute the Jacobian at the equilibrium
                stability = ForwardDiff.derivative(f,eq)
                # Determine the stability by checking the sign 
                if stability < 0
                        push!(stable, eq)
                else
                        push!(unstable, eq)
                end
        end

        # Return all the equilibria 
        return (
                stable = stable,
                unstable = unstable
               ) 
end

"""
    get_equilibria(f1, f2; kwargs...)

Overload of `get_equilibria` to find the roots of a 2-dimensional vector field with components `f1` and `f2` at parameter `μ`.
"""
function get_equilibria(f1::Function, f2::Function, μ::Float64; guesses=[[-10.0, -10.0], [0, 0], [-2.0, -2.0], [2.0, 2.0]])
        # Redine unparametrised vector field
        f(x,y) = f1(x,y,μ)
        g(x,y) = f2(x,y,μ)

        # Define empty arrays to separate stable from unstable equilibria
        stable = Vector{Vector{Float64}}()
        unstable = Vector{Vector{Float64}}()

        # Loop over the guesses
        for guess in guesses
                # Extract the components of the guess
                x0 = guess[1]
                y0 = guess[2]

                # Solve f(x,y) = 0 for x, given y0
                X = find_zero(x -> f(x, y0), x0)
                # Solve g(x,y) = 0 for y, given x_sol
                Y = find_zero(y -> g(X, y), y0)

                # Avoid exporting duplicates
                if any(norm([X, Y] - [sx, sy]) < 1e-6 for (sx, sy) in vcat(stable, unstable))
                        continue
                end

                # Compute the linearisation (Jacobian)
                J = ForwardDiff.jacobian(u -> [f(u[1], u[2]), g(u[1], u[2])], [X, Y])
                # Compute the spectrum of the linear field (eigenvalues of the Jacobian)
                eigvals_J = eigen(J).values

                # Establish asymptotic stability
                if all(real.(eigvals_J) .< 0)
                        push!(stable, [X, Y])
                else
                        push!(unstable, [X, Y])
                end
        end

        # Return all the equilibria 
        return (
                stable = stable,
                unstable = unstable
               ) 
end
