"""
    Figures layout

Generation of the layouts and formats of the figures.
"""

#----------------#
#    Figure 1    #
#----------------#

fig1, ax1 = makefig(size = [1200,1200],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    limits = ((-3,3), (-3,3)),
                    x_ticks = [-3,0,3],
                    y_ticks = [-3,0,3],
                    lab = [L"\mathbf{x}", L"\mathbf{y}"],
                    ticks_lab_trunc = [0,0]
                   )

#----------------#
#    Figure 2    #
#----------------#

fig2, ax2 = makefig(size = [1200,1200],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    limits = ((0.25,1.75), (-0.75,0.75)),
                    x_ticks = [0.25,1,1.75],
                    y_ticks = [-0.75,0,0.75],
                    lab = [L"\mathbf{x}", L"\mathbf{y}"],
                    ticks_lab_trunc = [2,2]
                   )

#----------------#
#    Figure 3    #
#----------------#
 
fig3, ax3 = makefig(size = [1200,1200],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    limits = ((-3,3), (-3,3)),
                    x_ticks = [-3,0,3],
                    y_ticks = [-3,0,3],
                    lab = [L"\mathbf{u}", L"\mathbf{v}"],
                    ticks_lab_trunc = [0,0]
                   )


