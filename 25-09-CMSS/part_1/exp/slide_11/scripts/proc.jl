"""
    Postprocessing script

In here we define the quantities used for postprocessing the results.
"""

# Data structures for storing the results
x1 = Vector{Float64}()          # Persistent stable equilibrium
λ1 = Vector{Float64}()          # Parameter values 
x2 = Vector{Float64}()          # Saddle-node stable equilibrium
λ2 = Vector{Float64}()          # Parameter values 
x3 = Vector{Float64}()          # Saddle-node unstable equilibrium
λ3 = Vector{Float64}()          # Parameter values 

# Compute the drifting quasi-steady equilibria (qses)
function get_qses(solution)
        # Extract the parameter shift
        Λ = solution.param

        # Loop over the shifted paramater values
        for λ in Λ
                # Compute all equilibria at current parameter value
                equilibria = get_equilibria(f, λ, domain=[-10,+10])

                # Split the equilibria into stable and unstable ones
                stable = sort(equilibria.stable, rev=true)
                unstable = equilibria.unstable 

                # Check if you are in the region of bistability
                if length(stable)==2 
                        push!(x1, stable[1])
                        push!(λ1, λ)
                        push!(x2, stable[2])
                        push!(λ2, λ)
                else
                        push!(x1, stable[1])
                        push!(λ1, λ)
                end

                # Check if the unstable equilibrium exists
                if length(unstable) == 1
                        push!(x3, unstable[1])
                        push!(λ3, λ)
                end
        end
end
