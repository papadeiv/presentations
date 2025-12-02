"""
    Figures layout

Generation of the layouts and formats of the figures.
"""

#----------------#
#    Figure 1    #
#----------------#

fig1, ax1 = makefig(size = [1200,1200],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    toggle_title = true,
                    lab = [L"\mathbf{x}", L"\mathbf{f(x)}"],
                    ticks_lab_trunc = [1,2]
                   )

#----------------#
#    Figure 2    #
#----------------#

fig2, ax2 = makefig(size = [1200,1200],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    toggle_title = true,
                    lab = [L"\mathbf{x}", L"\mathbf{V(x)}"],
                    ticks_lab_trunc = [1,2]
                   )
