#to distribute the montgomery coefficients in F_p

import random as rn

a = rn.randint(1,p)
b = rn.randint(1,p)
def hashp(A, max_exp, length):
    return (A * a + b) % p

#the 'pseudorandom function' needed for the recursion

def hashfunc(A, max_exp, length):
    digits = [ ]
    B = hashp(A,max_exp, length)
    for i in range(2 * length):
        digit = B // (( 2 * max_exp + 1) ** (2 * length - i))
        digits.append(digit)
        B = B - ( B // ((2 * max_exp + 1) ** (2 * length - i))) * ((2 * max_exp + 1) ** (2 * length - i))
    new_vec = [((digits[i] + digits[i + length]) % (int(2 * max_exp + 1))) - max_exp for i in range(length)]
    return new_vec

#for adding and subtracting vectors

from operator import sub
from operator import add

#returns the endpoint of a t long pseudorandom walk

def rw_endpoint_endideal(t):
	endpoint = 0
	endideal =	private()					#initialize to 0
	rand_exp = endideal
	for i in range(t):
		if i > 0:
			endideal = list( map(add, endideal, rand_exp))
		endpoint = action(endpoint, rand_exp)
		rand_exp = hashfunc(int(endpoint), max_exp, len(ls))
	return [endpoint, endideal]

#returns a dictionary in which the keys are the s endpoints in the graphs of t long pseudorandom walks and the values are the vectors whose action takes you there starting from the point 0

def rw_ends_dict(s, t):
	ends = dict()
	for i in range(s):
		rw = rw_endpoint_endideal(t)
		ends[rw[0]] = rw[1]
	return ends
