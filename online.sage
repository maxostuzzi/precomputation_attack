#create a private and a public key
private_k = private()
public_k = action(0, private_k)

#input the hints from precomputation, a public key and the length of the walks and returns either the solution or fails
def detect_collision(dict_ends, pub, t):
	mont = pub
	boolean = False
	if mont in dict_ends.keys():
		boolean = True
	hint_ideal = private()
	rand_ideal = hint_ideal
	k = 0                    #counter
	while boolean == False and k < 2*t:
		if k > 0:
			hint_ideal = list(map(add, hint_ideal, rand_ideal))
		mont = action(mont, rand_ideal)
		if mont in dict_ends.keys():
			boolean = True
		rand_ideal = hashfunc(int(mont), max_exp, len(ls))
		k = k+1
	if boolean:
		return [mont, dict_ends[mont], hint_ideal]
	else:
		return 'Unsuccessful'

#preforms only the online part, taking input the hints, the number of walks and their lengths and returning the solution or failing
		
def online_attack(D, s, t):

	private_key = private()
	public_key = action(0,private_key)
	result = detect_collision(D, public_key, t)
	print('The private key is ', private_key)
	print('The public key is ', public_key)
	if result == 'Unsuccessful':
		return result
	else:
		print('Success! The collision is ', result[0], '.')
		print('The ideal is ', result[1], 'and you should subtract ', result[2] )
		print('You should get ', list(map(sub, result[1], result[2])))

#performs full attack, both precomputation and online phases. Takes number of precomputed walks and their length as inputs and returns either the result or fails 

def full_attack(s, t):

	private_key = private()
	public_key = action(0,private_key)
	precomputation = rw_ends_dict(s, t)
	result = detect_collision(precomputation, public_key, t)
	print('The private key is ', private_key)
	print('The public key is ', public_key)
	if result == 'Unsuccessful':
		return result
	else:
		print('Success! The collision is ', result[0], '.')
		print('The ideal is ', result[1], 'and you should subtract ', result[2] )
		print('You should get ', list(map(sub, result[1], result[2])))


