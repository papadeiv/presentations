"""
    Figures layout

Generation of the layouts for the figures of the simulations.
"""

#----------------#
#    Figure 1    #
#----------------#

# Figure for the timeseries 
fig1, ax1 = makefig(size = [1600,800],
                    pad = (20,40,20,20), # Order is: left, right, bottom, top 
                    bg_out = :white,
                    box_position = [1,1],
                    limits = ((-0.75,0), (0,0.02)),
                    lab = [L"\mathbf{\mu}", L"\textbf{Var[}\mathbf{x_t}\textbf{]}"],
                    x_ticks = [-0.75,0],
                    y_ticks = [0,0.02],
                    ticks_lab_trunc = [0,2]
                   )
