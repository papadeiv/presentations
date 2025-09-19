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
        # Loop over the parameter values
        for n in 1:length(μ)
                # Create empty layouts for the figures
                include("./scripts/figs.jl")

                # Plot and export the figures
                plot_figures(μ[n])
                savefig("slide_06_1_$n.png", fig1)
                savefig("slide_06_2_$n.png", fig2)
        end
        
        # Plot and export the analog of the vector field
        plot_vector_analog()
        savefig("slide_06_1_1_2.png", fig1)
end

# Execute the main
main()
