# HMMT 2020 feb 1
using Crayons
vert = Crayon(foreground = :green)
bleu = Crayon(foreground = :blue)
jaune = Crayon( italics = true , foreground = 0xffff00)
a=[1]
b=[string(a[1])]
for k in 1:2^11-1
    if k%2==1
        t=Int(div(k,2))
        push!(a,a[t+1])
        push!(b,string(a[t+1]))
    else
        t=Int(div(k,2))
        push!(a,(a[t]+a[t+1]))
        push!(b,string((a[t]+a[t+1])))
    end
end
max = maximum(a)
println(a)
l=length(b)
for i in 1:l
    if a[i]==1
        print(vert(b[i]) , "  ")
    else
        if a[i]<max
            print(bleu(b[i]), "  ")
        else
            print(jaune(b[i]) , "  ")
        end
    end
end    
somme=0
for i in 1:2^11
    somme += a[i]
end
println(somme)
indice = 1
while a[indice] < max
    indice += 1
end
println(jaune(b[indice]))


using CairoMakie
fig = Figure()
ax = Axis(fig[1, 1], title = "Représentation de la suite", xlabel = "Indices", ylabel = "Valeurs")
scatter!(ax, 1:length(a), a)
fig