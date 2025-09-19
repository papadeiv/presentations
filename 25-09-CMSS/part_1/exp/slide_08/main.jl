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
        for n in 1:length(u0)
                # Solve the IVP for the current IC
                solution = evolve_2d(f, g, η, η, μ, u0[n]; δt=δt, Nt=Nt)
                t = solution.time
                u = solution.states

                # Solve the IVP for the current IC
                solution = evolve_2d(f, g, η, η, μ, u0_close[n]; δt=δt, Nt=Nt)
                t = solution.time
                u_close = solution.states

                # Solve the linearised system for the current IC
                solution = evolve_2d(Df, Dg, Dη, η, μ, u0[n]; δt=δt, Nt=Nt)
                t = solution.time
                v = solution.states

                # Plot the phase space trajectory of the nonlinear and linearised system 
                plot_solution(t, u, u_close, v)
        end

        # Export the figure
        savefig("slide_08_1.png", fig1)
        savefig("slide_08_2.png", fig2)
        savefig("slide_08_3.png", fig3)
end

# Execute the main
main()
