# Une fonction pour la décomposition 
# en produit de facteurs premiers d'un nombre

function f(n)
    facteurs = []
    i = 2
    while i * i <= n
        if n % i != 0
            i += 1
        else
            n ÷= i
            push!(facteurs, i)
        end
    end
    if n > 1
        push!(facteurs, n)
    end
    return facteurs
end























function g(n)
    facteurs = []
    i = 2
    while i * i <= n
        n % i !=0 ? i+=1 : (n ÷= i ; push!(facteurs, i)) 
    end
    if n > 1
        push!(facteurs, n)
    end
    return facteurs
end