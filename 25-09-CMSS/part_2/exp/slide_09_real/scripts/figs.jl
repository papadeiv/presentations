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

fig1, ax1 = makefig(size = [1600,1400],
                    pad = (20,100,20,20), # Order is: left, right, bottom, top 
                    bg_out = :white,
                    box_position = [1,1],
                    lab = [L"\mathbf{t}", L"\mathbf{x_t}"],
                    toggle_lab = [false,true],
                    toggle_ticks_lab = [false,true],
                    ticks_lab_trunc = [0,1]
                   )

fig2, ax2 = makefig(fig = fig1,
                    box_position = [2,1],
                    lab = [L"\mathbf{t}", L"\textbf{Var}"],
                    ticks_lab_trunc = [0,3]
                   )


rowgap!(fig1.layout, 50)
