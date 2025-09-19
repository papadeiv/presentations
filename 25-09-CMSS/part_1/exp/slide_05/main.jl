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
        printstyled("Solving the ODE for different ICs\n"; bold=true, underline=true, color=:light_blue)
        @showprogress for n in 1:Nx
                # Solve the IVP
                solutions = evolve_1d(f, η, μ, [u0[n]], δt=δt, Nt=Nt)
                push!(trajectories, solutions.states[1])
                global time = solutions.time
        end

        # Plot and export the figures
        plot_solutions(time, trajectories)
        savefig("slide_05_1.png", fig1)
        savefig("slide_05_2.png", fig2)
        savefig("slide_05_3.png", fig3)
end

# Execute the main
main()
