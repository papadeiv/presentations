"""
    ?

???
"""

# Import the necessary packages and local modules
include("inc.jl")

# Import the simulation's scripts
include("./scripts/sim.jl")
include("./scripts/proc.jl")
include("./scripts/plot.jl")

# Define the main algorithm
function main()
        # Loop over the initial conditions
        printstyled("Solving the nonautonomous system for different initial conditions\n"; bold=true, underline=true, color=:light_blue)
        @showprogress for n in 1:length(u∞)
                # Solve the non-autonomous IVP
                solution = evolve_shifted_2d(f1, f2, Λ, η, η, u∞[n], t∞; Nt=Nt)

                # Plot the pullback attractor
                n == 0 && (plot_pb_attractor(solution))

                # Plot the solution
                plot_solution(solution)
        end

        # Export the figure
        savefig("slide_13.png", fig1)
end

# Execute the main
main()
