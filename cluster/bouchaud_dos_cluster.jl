@everywhere include("../src/SparseBarratMezard.jl")
@everywhere using .SparseBarratMezard
@everywhere using JLD


@everywhere function dos(lambda, T; N = 10^4, c = 3,
             ensemble = 10^7, ep2 = [1e-3, 1e-4, 1e-5])
    a = load("../data/populations/Bouchaud/T=$(T)/lambda=$(lambda)N=$(N)c=$(c)epsi_trescientos.jld")
    pop = a["pop"]
    
    dos = DOS(lambda, c, T, N, ensemble, ep2, pop)

    return dos
end

@everywhere function dos2(lambda, c; N = 10^4, T = 0.6,
             ensemble = 10^7, ep2 = [1e-3, 1e-4, 1e-5])
    a = load("../data/populations/Bouchaud/T=$(T)/lambda=$(lambda)N=$(N)c=$(c)epsi_trescientos.jld")
    pop = a["pop"]
    
    dos = bouchaud_DOS(lambda, c, T, N, ensemble, ep2, pop)

    return dos
end


#@everywhere l_grid = -exp10.(range(-3,stop =0, length = 101))
#@everywhere cs = [5, 10,20,100]

#@everywhere cs = [5, 20, 100]
@everywhere cs = [3]
@everywhere l_grid = collect(-1:0.01:0.)

for c in cs
   println(c)
  dos_pp = pmap(x -> dos2(x,c), l_grid)
    save("../data/dos/Bouchaud/T=0.6c=$(c).jld", "dos", dos_pp, "lambda",l_grid,  "ensemble", 10^7, "epsilon2", [1e-3, 1e-4, 1e-5])
end


#@everywhere l_grid = collect(-1:0.01:0.)
#@everywhere l_grid = -exp10.(range(-3,stop =0, length = 101))
#@everywhere T_grid  = [0.2, 0.35,0.5,0.8]

#for T in T_grid
#    println(T)
#@everywhere T = 0.1
#dos_pp = pmap(x -> dos(x,T), l_grid)
#save("../data/dos/T=$(T)c=3.jld", "dos", dos_pp, "lambda",l_grid,
  #   "ensemble", 10^7, "epsilon2", [1e-3, 1e-4, 1e-5])
#end



    
