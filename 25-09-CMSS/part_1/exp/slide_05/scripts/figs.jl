"""
    Figures layout

Generation of the layouts and formats of the figures.
"""

#----------------#
#    Figure 1    #
#----------------#

fig1, ax1 = makefig(size = [1600,700],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    lab = [L"\textbf{time}", L"\textbf{population (%)}"],
                    toggle_lab = [true, true],
                    toggle_ticks_lab = [true, true],
                    ticks_lab_trunc = [0,1]
                   )

#----------------#
#    Figure 2    #
#----------------#

fig2, ax2 = makefig(size = [1600,700],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    lab = [L"\textbf{time}", L"\textbf{population (%)}"],
                    toggle_lab = [true, true],
                    toggle_ticks_lab = [true, true],
                    ticks_lab_trunc = [0,1]
                   )

#----------------#
#    Figure 3    #
#----------------#

fig3, ax3 = makefig(size = [1600,700],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    box_position = [1,1],
                    lab = [L"\textbf{time}", L"\textbf{population (%)}"],
                    toggle_lab = [true, true],
                    toggle_ticks_lab = [true, true],
                    ticks_lab_trunc = [0,1]
                   )
