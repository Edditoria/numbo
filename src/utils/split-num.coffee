export default (input) ->
	# `input` should be a string or number of positive number (integer or float), e.g. 'nnnnnnnn.dddd'
	# return an array ['nnnnnnnn', 'dddd']
	# if there is no decimal place, will return ['nnnn', '']
	if typeof input isnt 'string' then input = input.toString() # for safety
	if input.indexOf('.') is -1
		output = [input, '']
	else
		output = input.split('.')
	if output[0] is '' then output[0] = '0'
	output
