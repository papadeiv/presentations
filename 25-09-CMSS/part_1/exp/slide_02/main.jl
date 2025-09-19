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
        # Solve May's vegetation cover model
        May = evolve_shifted_1d(f, g, η, x0, t∞, Nt=Nt)

        # Import the data from csv
        deMonecal = readCSV("slide_02/deMonecal00.csv")
        Diks = readCSV("slide_02/Diks18_index.csv")

        # Plot and export the timeseries
        plot_timeseries(May, deMonecal, Diks)
        savefig("slide_02.png", fig1)
end

# Execute the main
main()
