"""
    Figures layout

Generation of the layouts and formats of the figures.
"""

#----------------#
#    Figure 1    #
#----------------#

fig1, ax1 = makefig(size = [1600,700],
                    pad = (20,100,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    lab = [L"\mathbf{t}", L"\mathbf{x_t}"],
                    ticks_lab_trunc = [0,1]
                   )
