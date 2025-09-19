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

fig1, ax1 = makefig(size = [1600,1200],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    bg_out = :white,
                    limits = ((-1,1), (-2.2, 2.2)),
                    lab = [L"\mathbf{\lambda}", L"\mathbf{x(\lambda(t))}"],
                    x_ticks = [-1,1],
                    y_ticks = [-2,2],
                    ticks_lab_trunc = [0,0]
                   )

fig2, ax2 = makefig(fig = fig1, 
                    box_position = [2,1],
                    limits = ((-200,200), (-1.1, 1.1)),
                    lab = [L"\mathbf{t}", L"\mathbf{\lambda(t)=\varepsilon\,t}"],
                    x_ticks = [-200,0,200],
                    y_ticks = [-1,1],
                    ticks_lab_trunc = [0,0]
                   )
