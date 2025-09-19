"""
    ?

???
"""

# Import the necessary packages and local modules
include("inc.jl")

# Import the simulation's scripts
include("./scripts/sim.jl")
include("./scripts/plot.jl")

# Define the main algorithm
function main()
        # Loop over the different parameter regions
        printstyled("Solving the ODE for different parameter regions\n"; bold=true, underline=true, color=:light_blue)
        @showprogress for m in 1:Nμ
                # Extract the current parameter vector
                μ = A[m]

                # Loop over the initial conditions
                solutions = Vector{Vector{Float64}}()
                for n in 1:Nx
                        # Solve the IVP for the current IC
                        solution = evolve_1d(f, η, μ, [u0[n]], δt=δt, Nt=Nt)
                        n ==1 && push!(solutions, solution.time)
                        push!(solutions, solution.states[1])
                end

                # Plot the solutions timeseries and the point in the bifurcation set
                plot_solutions(solutions, m)
        end

        # Export the figure
        savefig("slide_10_2.png", fig1)
        savefig("slide_10_1.png", fig5)
end

# Execute the main
main()
