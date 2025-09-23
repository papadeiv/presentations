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
        @showprogress for n in 1:Nθ
                # Solve and plot the IVP in phase space 
                solution = evolve_2d(f1, f2, η, η, μ0, u0[n]; δt=δt, Nt=Nt)
                plot_solution(solution.states)

                # Compute first passage time
                push!(first_passage_time, compute_first_passage(solution))
        end

        # Export the sample paths figure
        #savefig("slide_05_1.png", fig1)

        # Add, plot and export a representative trajectory
        solution = evolve_2d(f1, f2, η, η, μ0, [ρ*cos(pi/4),ρ*sin(pi/4)]; δt=δt, Nt=Nt)
        plot_solution(solution.states, "special")
        #savefig("slide_05_2.png", fig1)

        # Plot and export the distribution of the first passage
        plot_first_passage(first_passage_time)
        savefig("slide_05_4.png", fig2)
end

# Execute the main
main()
