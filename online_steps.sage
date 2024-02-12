# counts number of steps and re-randomizes after 2t steps

def steps4collision(dict_ends,  t, max_steps):
  steps = 0
  boolean = False
  mont = action(0, private())
  if mont in dict_ends.keys():
    boolean = True
  while boolean == False and steps < max_steps:
    rand_ideal = private()
    k = 0                   
    while boolean == False and k < 2*t:
      mont = action(mont, rand_ideal)
      if mont in dict_ends.keys():
        boolean = True
      rand_ideal = hashfunc(int(mont), max_exp, len(ls))
      steps = steps + 1
      k +=1
  if boolean:
    return [steps, floor(steps/(2*t))]
  else:
    return [max_steps, max_steps/(2*t), 'not enough']

#it is parallelizable

import concurrent.futures 
import timeit 
import pickle
import statistics as stat

# each worker returns a list [number of steps, number of re-randomizations]

def worker(i):
	print(i) 
	set_random_seed(int(i) + 20)
	result = steps4collision(B, t, maximum_steps)
	return result

def test():
	with concurrent.futures.ProcessPoolExecutor(max_workers = times) as executor: 
		results = list(executor.map(worker, range(times)))
	return results



# times = 10 experiments for each prime and see how many online phases it takes, with maximum maximum_steps = 10*2*t
# it builds a dictionary in which keys are primes and values are lists with items [number of steps, number of re-randomizations]

result_dict = {}
times = 10
for key, value in prime_dict.items():
	print(key)
	print(value)
	ls = value # Elkies primes
	p = 4 * prod(ls) - 1
	max_exp = ceil((sqrt(p) ** (1/len(ls)) - 1) / 2)
	t = ceil((2*max_exp+1)^(len(ls)/3))
	s = ceil((2*max_exp+1)^(len(ls)/3))
	maximum_steps = 10*2*t
	Fp2.<i> = GF(p**2, modulus = x**2 + 1)
	B = rw_ends_dict(s, t)
	result_dict[key] = test()
	with open("online","wb") as f1:
		pickle.dump(result_dict, f1)

# builds a dictionary in which keys are primes and values are averages for the number of steps

means = {}
for prime in result_dict.keys(): 
	means[prime] = stat.fmean([run[0] for run in result_dict[prime]])
