"""
    Figures layout

Generation of the layouts and formats of the figures.
"""

#----------------#
#    Figure 1    #
#----------------#

fig1 = Figure()
ax1 = Axis3(fig1[1, 1], 
            aspect = (2, 1, 1),
            azimuth = 1.175pi,
            elevation = pi/8,
            xlabel = L"\textbf{time}",
            ylabel = L"\mathbf{x}",
            zlabel = L"\mathbf{y}",
            xgridvisible = false,
            ygridvisible = false,
            zgridvisible = false,
            limits = ((-T,T),(-10,1),(-10,1)),
            xticks = [-T,0,T],
            yticks = [-10,1],
            zticks = [-10,1],
            front_spines = true,
            title = L"\mathbf{\varepsilon = %$ε}",
            titlesize = 20,
            titlegap = -70.0,
            protrusions = (5,0,10,0),
            perspectiveness = 1.0
           )
