"""
    Figures layout

Generation of the layouts for the figures of the simulations.
"""

#----------------#
#    Figure 1    #
#----------------#

# Figure for the timeseries 
fig1, ax1 = makefig(size = [1600,1200],
                    pad = (20,40,20,20), # Order is: left, right, bottom, top 
                    bg_out = :white,
                    box_position = [1,1],
                    limits = ((0,10), (-0.1,1.1)),
                    lab = [L"\mathbf{t}", L"\mathbf{\phi}"],
                    x_ticks = [0,10],
                    y_ticks = [0,1],
                    ticks_lab_trunc = [0,0]
                   )

fig2, ax2 = makefig(fig = fig1,
                    box_position = [2,1],
                    limits = ((0,4), (0,2)),
                    lab = [L"\mathbf{T}", L"\mathbf{S[\phi]}"],
                    x_ticks = [0,4],
                    y_ticks = [0,2],
                    ticks_lab_trunc = [0,0]
                   )
