"""
    Figures layout

Generation of the layouts for the figures of the simulations.
"""

CtpMauve = colorant"rgb(202,158,230)"
CtpTeal = colorant"rgb(129, 200, 190)"
CtpBlue = colorant"rgb(140, 170, 238)"
CtpRed = colorant"rgb(231, 130, 132)"
CtpYellow = colorant"rgb(229,200,144)"
CtpWhite = colorant"rgb(198,208,245)"
CtpGray = colorant"rgb(98,104,128)"

#----------------#
#    Figure 1    #
#----------------#

# Figure for the timeseries 
fig1, ax1 = makefig(size = [1200,1200],
                    pad = (20,40,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    limits = ((-1, 3.5), (-1, 3)),
                    lab = [L"\mathbf{x}", L"\mathbf{V(x)}"],
                    x_ticks = [-1,3.5],
                    y_ticks = [-1,3],
                    ticks_lab_trunc = [0,0]
                   )

#----------------#
#    Figure 2    #
#----------------#

# Figure for the timeseries 
fig2, ax2 = makefig(size = [1200,800],
                    pad = (20,40,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    lab = [L"\mathbf{t}", L"\mathbf{x_t}"],
                    ticks_lab_trunc = [0,1]
                   )
