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
                    limits = ((-1.5,+1.5), (-0.5,+0.5)),
                    x_ticks = [-1.5,0,+1.5],
                    y_ticks = [-0.5,0,+0.5],
                    lab = [L"\mathbf{x}", L"\mathbf{y}"],
                    ticks_lab_trunc = [1,1]
                   )
