"""

"""

# Import the necessary packages and local modules
include("inc.jl")

# Import the simulation's scripts
include("./scripts/sim.jl")
include("./scripts/plot.jl")

# Define the main algorithm
function main()
        # Plot the figure 
        plot(Y, T)

        # Export the figure
        savefig("slide_06.png", fig1)
end

# Execute the main
main()
