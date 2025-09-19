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

fig1, ax1 = makefig(size = [1200,1200],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    toggle_title = true,
                    title = L"\mathbf{f(x,y) = [\sqrt{|x|}, -y]^{T}}",
                    limits = ((-1,1), (-1,1)),
                    x_ticks = [-1,0,1],
                    y_ticks = [-1,0,1],
                    lab = [L"\mathbf{x}", L"\mathbf{y}"],
                    ticks_lab_trunc = [0,0]
                   )

#----------------#
#    Figure 2    #
#----------------#

fig2, ax2 = makefig(size = [1200,800],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    toggle_title = true,
                    title = L"\mathbf{f(x,y) = [\sqrt{|x|}, -y]^{T}}",
                    limits = ((0,3), (-1,1)),
                    x_ticks = [0,3],
                    y_ticks = [-1,0,1],
                    lab = [L"\mathbf{t}", L"\mathbf{x}"],
                    ticks_lab_trunc = [0,0]
                   )
