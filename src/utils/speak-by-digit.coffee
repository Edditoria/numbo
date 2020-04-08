export default (str, n1, separator = ' ') ->
	# match every characters of `str` to `n1[str]` one-by-one
	# the 1st arg should a string contains numbers only (e.g. '000123')
	# return a string (e.g. 'zero zero zero one two three')
	if typeof str is 'string' and str.search(/\D/g) < 0
		output = []
		output.push(n1[+item]) for item in str
		output.join(separator)
	else
		console.log 'Error: Invalid argument of speakByDigit()'
		null
