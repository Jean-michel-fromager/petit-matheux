# Triangle qui apparaît et disparaît

using GLMakie
using GeometryBasics    # Permet de tracer des figures
using Colors            # Les couleurs RGB avec une valeur de α
GLMakie.activate!() # Définit GKMakie comme backend par défaut
GLMakie.closeall() # Efface toutes les fenêtres GLMakie si certaines sont ouvertes
set_theme!(theme_dark())

A = Point3f(1,2,3) # Les trois points du triangle
B = Point3f(3,2,0)
C = Point3f(0,3,1)
sommets = Point3f[A ,B, C] # Configuration des sommets

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

xlims!(repere, -1, 3)   # Paramétrage du repère
ylims!(repere, -1, 3)
zlims!(repere, -1, 3)
face_triangle = [TriangleFace(1, 2, 3)]    # Configuration de la face
triangle = GeometryBasics.Mesh(sommets, face_triangle)     # Configuration du maillage de la face
initial_color = Observable(RGBAf(0.9, 0.9, 0.9, 1.0))       # La couleur devient un observable
mesh!(repere, triangle, transparency = true, color = initial_color)     # Tracé du triangle

transparence = Slider(fig[2, 1], linewidth = 20, range = 0:0.001:1, startvalue = 0)     # Création d'un slider pour gérer la transparence

on(transparence.value) do t     # La valeur donnée à t grâce au slider modifie l'aspect du triangle 
    current_color = initial_color[] # Récupère la valeur initiale de l'Observable
    initial_color[] = RGBAf(red(current_color), green(current_color), blue(current_color), 1-t)     # La couleur évolue
end

fig

# Et maintenant, un tétraèdre
using GLMakie
using GeometryBasics
using Colors
GLMakie.activate!()
GLMakie.closeall() # Ferme les fenêtres éventuellement ouvertes

set_theme!(theme_dark())
A = Point3f(1,2,3) # Les quatre sommets du tétraèdre
B = Point3f(3,2,0)
C = Point3f(0,3,1)
D = Point3f(0,0,0)


sommets_tetra = Point3f[A ,B, C, D]  # Configuration des sommets

faces_indices = [
    1 2 3; # Face ABC
    1 2 4; # Face ABD
    1 3 4; # Face ACD
    2 3 4  # Face BCD
]

# Convertir chaque ligne de la matrice en un TriangleFace
faces = [TriangleFace(row...) for row in eachrow(faces_indices)]

fig = Figure()
repere = Axis3(fig[1, 1],
    perspectiveness = 0.9,
    elevation = 0.25π,
    azimuth = 1.25π,
    aspect = :data, # Permet d'avoir un aspect respectant les dimensions 
    title = "Un tétraèdre",
    xlabel = "x", ylabel = "y", zlabel = "z"
)
xlims!(repere, -1, 3)   # Paramétrage du repère
ylims!(repere, -1, 3)
zlims!(repere, -1, 3)

tetra_mesh = GeometryBasics.Mesh(sommets_tetra, faces)  # Configuration du maillage des faces
initial_color = Observable(RGBAf(0.0, 1.0, 1.0, 1.0))   # La couleur devient un observable
mesh!(repere, tetra_mesh, # Utilise l'objet Mesh créé
    color = initial_color,   # Couleur des faces
    transparency = true, # Tranparence des faces
    shading = MultiLightShading # Active l'ombrage
)

wireframe!(repere, tetra_mesh, color = :white, linewidth = 2)

variations_couleurs = Slider(fig[2, 1], linewidth = 20, range = 0:0.001:1, startvalue = 0)

on(variations_couleurs.value) do t
    current_color = initial_color[] # Récupère la valeur actuelle de l'Observable
    initial_color[] = RGBAf(t, 1-t, 1.0, 1.0-(t/2))
end

display(fig)
