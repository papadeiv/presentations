"""
    Figures layout

Generation of the layouts and formats of the figures.
"""

#----------------#
#    Figure 1    #
#----------------#

fig1, ax1 = makefig(size = [1600,1600],
                    pad = (20,60,20,20), # Order is: left, right, bottom, top 
                    bg_out = :white,
                    box_position = [1,1],
                    lab = [L"\mathbf{t}", L"\mathbf{x_t}"],
                    toggle_lab = [false,true],
                    toggle_ticks_lab = [false,true],
                    ticks_lab_trunc = [0,1]
                   )

fig2, ax2 = makefig(fig = fig1,
                    box_position = [2,1],
                    lab = [L"\mathbf{t}", L"\textbf{exp}\mathbf{(-\Delta V)}"],
                    toggle_lab = [false,true],
                    toggle_ticks_lab = [false,true],
                    ticks_lab_trunc = [0,1]
                   )

fig3, ax3 = makefig(fig = fig1,
                    box_position = [3,1],
                    lab = [L"\mathbf{t}", L"\mathbf{||V - V_{*}||_2}"],
                    ticks_lab_trunc = [0,1]
                   )

rowgap!(fig1.layout, 50)
