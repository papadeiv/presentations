"""
    Figures layout

Generation of the layouts and formats of the figures.
"""

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
                    lab = [L"\mathbf{t}", L"\mathbf{y_t}"],
                    ticks_lab_trunc = [0,1]
                   )

fig3, ax3 = makefig(fig = fig1,
                    box_position = [1,2],
                    lab = [L"\mathbf{t}", L"\mathbf{\psi_t}"],
                    title = L"\mathbf{\psi_t = x_t - y_t}",
                    toggle_title = true,
                    toggle_lab = [false,true],
                    toggle_ticks_lab = [false,true],
                    ticks_lab_trunc = [0,1]
                   )

fig4, ax4 = makefig(fig = fig1,
                    box_position = [2,2],
                    lab = [L"\mathbf{t}", L"\mathbf{\phi_t}"],
                    title = L"\mathbf{\phi_t = \cos(\beta)x_t + \sin(\beta)y_t}",
                    toggle_title = true,
                    ticks_lab_trunc = [0,1]
                   )

rowgap!(fig1.layout, 50)

#----------------#
#    Figure 2    #
#----------------#

fig5, ax5 = makefig(size = [1600,1400],
                    pad = (20,100,20,20), # Order is: left, right, bottom, top 
                    bg_out = :white,
                    box_position = [1,1],
                    lab = [L"\mathbf{t}", L"\mathbf{\psi_t}"],
                    toggle_lab = [false,true],
                    toggle_ticks_lab = [false,true],
                    ticks_lab_trunc = [0,1]
                   )

fig6, ax6 = makefig(fig = fig5,
                    box_position = [2,1],
                    lab = [L"\mathbf{t}", L"\textbf{Var}"],
                    ticks_lab_trunc = [0,2]
                   )

rowgap!(fig5.layout, 50)
