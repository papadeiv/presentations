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
                    box_position = [1,2],
                    limits = ((0,10), (-0.05, 1.05)),
                    title = L"\textbf{Coordination game}",
                    toggle_title = true,
                    lab = [L"\mathbf{t}", L"\mathbf{x}"],
                    toggle_lab = [false,false],
                    x_ticks = [0,10],
                    y_ticks = [0,1],
                    toggle_ticks_lab = [false,false],
                    ticks_lab_trunc = [0,0]
                   )

fig2, ax2 = makefig(fig = fig1, 
                    box_position = [1,1],
                    limits = ((0,10), (-0.05, 1.05)),
                    title = L"\textbf{Dominant strategy}",
                    toggle_title = true,
                    lab = [L"\mathbf{t}", L"\mathbf{x}"],
                    toggle_lab = [false,true],
                    x_ticks = [0,10],
                    y_ticks = [0,1],
                    toggle_ticks_lab = [false,true],
                    ticks_lab_trunc = [0,0]
                   )

fig3, ax3 = makefig(fig = fig1, 
                    box_position = [2,2],
                    limits = ((0,10), (-0.05, 1.05)),
                    title = L"\textbf{Dominant strategy}",
                    toggle_title = true,
                    lab = [L"\mathbf{t}", L"\mathbf{x}"],
                    toggle_lab = [true,false],
                    x_ticks = [0,10],
                    y_ticks = [0,1],
                    toggle_ticks_lab = [true,false],
                    ticks_lab_trunc = [0,0]
                   )

fig4, ax4 = makefig(fig = fig1, 
                    box_position = [2,1],
                    limits = ((0,10), (-0.05, 1.05)),
                    title = L"\textbf{Anti-coordination}",
                    toggle_title = true,
                    lab = [L"\mathbf{t}", L"\mathbf{x}"],
                    toggle_lab = [true,true],
                    x_ticks = [0,10],
                    y_ticks = [0,1],
                    toggle_ticks_lab = [true,true],
                    ticks_lab_trunc = [0,0]
                   )

# Adjust whitespace between contiguous plots 
colgap!(fig1.layout, 60)
rowgap!(fig1.layout, 60)

#----------------#
#    Figure 2    #
#----------------#

# Define limits of the set
ɑ_min = -(2.0::Float64)
ɑ_max = 2.0::Float64
β_min = -(2.0::Float64)
β_max = 2.0::Float64

# Create figure
fig5, ax5 = makefig(size = [1200,1200],
                    pad = (20,50,20,20), # Order is: left, right, bottom, top 
                    limits = ((ɑ_min, ɑ_max), (β_min, β_max)),
                    lab = [L"\mathbf{\alpha := a - c}", L"\mathbf{\beta := d - b}"],
                    x_ticks = [ɑ_min, 0, ɑ_max],
                    y_ticks = [β_min, 0, β_max],
                    ticks_lab_trunc = [0,0]
                   )

# Define the ɑ-domains for the admissible set Γ*
ɑ_dom_1 = LinRange(ɑ_min, 0, 1000)
ɑ_dom_2 = LinRange(0, ɑ_max, 1000)

# Shade the admissible set Γ*
band!(ax5, ɑ_dom_1, ones(1000).*β_min, zeros(1000), color = (:gray, 0.5))
band!(ax5, ɑ_dom_2, zeros(1000), ones(1000).*β_max, color = (:gray, 0.5))
# Plot the separatrices of the bifurcation set 
lines!(ax5, [0,0], [β_min,β_max], linewidth = 6, color = :black)
lines!(ax5, [ɑ_min,ɑ_max], [0,0], linewidth = 6, color = :black)
