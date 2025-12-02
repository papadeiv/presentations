"""
    Figures layout

Generation of the layouts and formats of the figures.
"""

#----------------#
#    Figure 1    #
#----------------#

fig1, ax1 = makefig(size = [1600,600],
                    pad = (20,40,20,20),
                    bg_out = :white,
                    box_position = [1,1],
                    lab = [L"\textbf{time}", L"\textbf{state}"],
                    ticks_lab_trunc = [0,1]
                   )

#----------------#
#    Figure 2    #
#----------------#

fig2, ax2 = makefig(size = [1600,600],
                    pad = (20,40,20,20),
                    bg_out = :white,
                    box_position = [1,1],
                    lab = [L"\textbf{time}", L"\textbf{state}"],
                    ticks_lab_trunc = [0,1]
                   )

#----------------#
#    Figure 3    #
#----------------#

fig3, ax3 = makefig(size = [2400,800],
                    pad = (20,100,20,20),
                    box_position = [1,1],
                    title = L"\textbf{vegetation grazing}",
                    toggle_title = true,
                    limits = ((0,200),(-0.5,8.5)),
                    lab = [L"\textbf{weeks}", L"\textbf{biomass}"],
                    x_ticks = [0,200],
                    y_ticks = [0,8],
                    ticks_lab_trunc = [0,0]
                   )

fig4, ax4 = makefig(fig = fig3,
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

fig5, ax5 = makefig(fig = fig3,
                    box_position = [1,3],
                    title = L"\textbf{08-09 global financial crisis}",
                    toggle_title = true,
                    limits = ((1,365),(0.6,1.5)),
                    lab = [L"\textbf{days}", L"\textbf{S&P 500}"],
                    ax_orientation = [true,false],
                    x_ticks = [365,1],
                    y_ticks = [0.65,1.45],
                   )

#----------------#
#    Figure 4    #
#----------------#

fig6, ax6 = makefig(size = [1200,800],
                    pad = (20,100,20,20),
                    box_position = [1,1],
                    title = L"\textbf{PhD's imposter syndrome}",
                    toggle_title = true,
                    limits = ((0,200),(-0.5,8.5)),
                    lab = [L"\textbf{years}", L"\textbf{confidence in my skills}"],
                    x_ticks = [0,200],
                    y_ticks = [0,8],
                    ticks_lab_trunc = [0,0]
                   )

#----------------#
#    Figure 5    #
#----------------#

fig7, ax7 = makefig(size = [1600,1200],
                    pad = (20,40,20,20),
                    bg_out = :white,
                    box_position = [1,1],
                    lab = [L"\textbf{time}", L"\textbf{state}"],
                    ticks_lab_trunc = [0,1]
                   )

fig8, ax8 = makefig(fig = fig7,
                    box_position = [2,1],
                    lab = [L"\textbf{time}", L"\textbf{Var[state]}"],
                    ticks_lab_trunc = [0,2]
                   )
