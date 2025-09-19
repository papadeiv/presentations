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
        # Solve the IVP for the current IC
        solution = evolve_shifted_1d(f, g, η, u∞, t∞, Nt=Nt, saveat=Δt)

        # Compute the drifting QSEs
        get_qses(solution)
                        
        # Loop over the timesteps
        printstyled("Exporting the plots at each timestep\n"; bold=true, underline=true, color=:light_blue)
        @showprogress for n in 1:length(solution.time)
                # Plot the non-autonomous solution and parameter shift 
                plot_solution(solution, n)

                # Export the figure
                savefig("slide_11/$n.png", fig1)
        end
end

# Execute the main
main()
