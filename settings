ls = list('''insert the list of primes you want''') # Elkies primes
p = 4 * prod(ls) - 1
max_exp = ceil((sqrt(p) ** (1/len(ls)) - 1) / 2)
t=ceil((2*max_exp+1)^(len(ls)/3))
s=ceil((2*max_exp+1)^(len(ls)/3))
Fp2.<i> = GF(p**2, modulus = x**2 + 1)
def montgomery_curve(A):
    return EllipticCurve(Fp2, [0, A, 0, 1, 0])
def montgomery_coefficient(E):	
    Ew = E.change_ring(GF(p)).short_weierstrass_model()
    _, _, _, a, b = Ew.a_invariants()
    R.<z> = GF(p)[]
    r = (z**3 + a*z + b).roots(multiplicities=False)[0]
    s = sqrt(3 * r**2 + a)
    if not is_square(s): s = -s
    A = 3 * r / s
    assert montgomery_curve(A).change_ring(GF(p)).is_isomorphic(Ew)
    return GF(p)(A)
def smallisog(pos=-1):   
    i = randrange(1, len(ls))
    res = list()
    for j in range(len(ls)):
        if pos <0:
            if j==i:
                res.append(1)
            else:
                res.append(0)
        else:
            if j==pos:
                res.append(1)
            else:
                res.append(0)
    return res
def private():
    return [randrange(-max_exp, max_exp + 1) for _ in range(len(ls))]

def action(pub, priv, debug=False):

    E = montgomery_curve(pub)
    es = priv[:]

    while any(es):

        E._order = (p + 1)**2 # else sage computes this

        P = E.lift_x(GF(p).random_element())
        s = +1 if P.xy()[1] in GF(p) else -1
        k = prod(l for l, e in zip(ls, es) if sign(e) == s)
        P *= (p + 1) // k

        for i, (l, e) in enumerate(zip(ls, es)):

            if sign(e) != s: continue
            Q = k // l * P
            if not Q: continue
            
            if debug: 
                print("\nP: \t\t", P)
                R = 2*P
                print("\n2P: \t\t", R)
                print("\nQ: \t\t", Q)
                print("\nOrd(P):\t", P.order())
                print("\nOrd(2P):\t", R.order())
                print()
                
                xcoord = P.xy()[0]

                tau = xcoord**2
                sigma = 2 * xcoord - (2/xcoord) 

                image = tau * (montgomery_coefficient(E) - 3*sigma)
                print("\nImage: ", image)

                print("\nxcoord: ", xcoord)
                guess = (27*xcoord**4 - 18*xcoord**2 -1)/(-4*xcoord)
                print("\nGuess: ", guess)
            Q._order = l # else sage computes this
            phi = E.isogeny(Q)


            E, P = phi.codomain(), phi(P)
            es[i] -= s
            k //= l

    return montgomery_coefficient(E)
