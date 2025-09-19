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

fig1, ax1 = makefig(size = [2400,800],
                    pad = (20,100,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    title = L"\textbf{vegetation grazing}",
                    toggle_title = true,
                    limits = ((0,200),(-0.5,8.5)),
                    lab = [L"\textbf{weeks}", L"\textbf{biomass}"],
                    x_ticks = [0,200],
                    y_ticks = [0,8],
                    ticks_lab_trunc = [0,0]
                   )

fig2, ax2 = makefig(fig = fig1,
                    box_position = [1,2],
                    title = L"\textbf{desertification of the Sahara}",
                    toggle_title = true,
                    limits = ((2,14),(18.5,27.5)),
                    lab = [L"\textbf{kyears BCE}", L"\textbf{SST}"],
                    ax_orientation = [true,false],
                    x_ticks = [14,2],
                    y_ticks = [19,27],
                    ticks_lab_trunc = [0,0]
                   )

fig3, ax3 = makefig(fig = fig1,
                    box_position = [1,3],
                    title = L"\textbf{08-09 global financial crisis}",
                    toggle_title = true,
                    limits = ((1,365),(0.6,1.5)),
                    lab = [L"\textbf{days}", L"\textbf{S&P 500}"],
                    ax_orientation = [true,false],
                    x_ticks = [365,1],
                    y_ticks = [0.65,1.45],
                   )
