"""
    Postprocessing script

In here we define the quantities used for postprocessing the results.
"""

# Data structures for storing the results
x1 = Vector{Float64}()          # Persistent stable equilibrium: x-component
y1 = Vector{Float64}()          # Persistent stable equilibrium: y-component
t1 = Vector{Float64}()          # Timestamps
x2 = Vector{Float64}()          # Saddle-node stable equilibrium: x-component
y2 = Vector{Float64}()          # Saddle-node stable equilibrium: y-component
t2 = Vector{Float64}()          # Timestamps 
x3 = Vector{Float64}()          # Saddle-node unstable equilibrium: x-component
y3 = Vector{Float64}()          # Saddle-node unstable equilibrium: y-component
t3 = Vector{Float64}()          # Timestamps
