
# Create empty layouts for the figures
include("./figs.jl")

function plot_solution(solution, parameter)
       # Extract the x and y component of the solutions
        x = solution[:,1]
        y = solution[:,2]

        # Plot the nonlinear trajectory in phase space
        lines!(ax1, x, y, color = (CtpGray,0.15), linewidth = 1.0)

        # Plot the stable manifolds for the sink and unstable manifolds
        domain_x = collect(LinRange(+1.00,+1.50,1000))
        domain_y = collect(LinRange(-0.50,+0.50,1000))
        lines!(ax1, domain_x, [0 for x in domain_x], color = CtpBlue, linewidth = 5.0)
        lines!(ax1, [+1 for y in domain_y], domain_y, color = CtpBlue, linewidth = 5.0)
        # Plot the stable eigenvectors
        v_x = [0, 0, -1]
        v_y = [1, -1, 0]
        arrows!(ax1, [1,1,1.5], [-0.25,+0.25,0], v_x, v_y, color = CtpBlue, arrowsize = 30, lengthscale = 0.1, linewidth = 5, align = :tip)

        # Plot the stable and unstable manifolds for the saddle
        domain_x = collect(LinRange(-1.50,-1.00,1000))
        domain_y = collect(LinRange(-0.50,+0.50,1000))
        lines!(ax1, domain_x, [0 for x in domain_x], color = CtpRed, linewidth = 5.0)
        lines!(ax1, [-1 for y in domain_y], domain_y, color = CtpBlue, linewidth = 5.0)
        # Plot the stable eigenvectors
        v_x = [0, 0]
        v_y = [1, -1]
        arrows!(ax1, [-1,-1], [-0.25,+0.25], v_x, v_y, color = CtpBlue, arrowsize = 30, lengthscale = 0.1, linewidth = 5, align = :tip)
        # Plot the unstable eigenvector
        v_x = [-1]
        v_y = [0]
        arrows!(ax1, [-1], [0], v_x, v_y, color = CtpRed, arrowsize = 30, lengthscale = 0.25, linewidth = 5)

        # Plot the heteroclinic orbit
        domain_x = collect(LinRange(-1.00,+1.00,1000))
        lines!(ax1, domain_x, [0 for x in domain_x], color = CtpMauve, linewidth = 5.0)
        # Plot the direction of the flow of the heteroclinic
        v_x = [1]
        v_y = [0]
        arrows!(ax1, [-0.15], [0], v_x, v_y, color = CtpMauve, arrowsize = 30, lengthscale = 0.1, linewidth = 5)

        # Plot the equilibria
        equilibria = get_equilibria(f1, f2, parameter)
        sink = equilibria.stable[1]
        saddle = equilibria.unstable[1]
        scatter!(ax1, sink[1], sink[2], color = CtpBlue, markersize = 30, strokewidth = 3.0)
        scatter!(ax1, saddle[1], saddle[2], color = CtpYellow, markersize = 30, strokewidth = 3.0)
end
