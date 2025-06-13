# Triangle qui se déforme
using GLMakie
using GeometryBasics
using Colors
set_theme!(theme_dark())
A = Point3f(1,2,3)
B = Point3f(3,0,0)
C = Point3f(0,3,1)
sommets = Point3f[A ,B, C]

# --- Création de la figure et des axes ---
fig = Figure()
repere = Axis3(fig[1, 1],
    perspectiveness = 0.1,
    elevation = 0.25π,
    azimuth = 1.25π,
    aspect = :data,
    title = "Un triangle",
    xlabel = "x", ylabel = "y", zlabel = "z"
)

xlims!(repere, -1, 3)
ylims!(repere, -1, 3)
zlims!(repere, -1, 3)
faces_triangle = [TriangleFace(1, 2, 3)]
triangle = GeometryBasics.Mesh(sommets, faces_triangle)
initial_color=Observable(RGBAf(0.9, 0.9, 0.0, 0.0))
mesh!(repere, triangle, transparency = true, color = initial_color)

transparence = Slider(fig[2, 1], linewidth = 20, range = 0:0.001:1, startvalue = 0)



on(transparence.value) do α
    current_color = initial_color[] # Récupère la valeur actuelle de l'Observable
    initial_color[] = RGBAf(red(current_color), green(current_color), blue(current_color), α)
end


fig