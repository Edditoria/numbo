export default (input, characters = '') ->
	# expect `input` is a string of integer or floating
	# features:
	# - remove leading '$', '+' and '-'
	# - remove leading and tailing zero
	# - remove any ',' before '.'
	# - add '0' if the input starts by '.' e.g. '.5'
	# remove '.' if no decimal place
	# accepts additional characters as 2nd argument #todo
	if typeof input isnt 'string' then input = input.toString() # for safety
	regexHead = /,|^[$|\-]*(0|,)*(?!\.)/g # e.g. '-$0,001,000' matches '$0,00'
	regexTail = /0*$/g
	dotIndex = input.indexOf('.')
	if dotIndex is -1
		output = input.replace(regexHead, '')
	else
		inputArr = tools.splitNum(input)
		inputArr[0] = inputArr[0].replace(regexHead, '')
		inputArr[1] = inputArr[1].replace(regexTail, '')
		output = inputArr.join('.')
	# if output is an empty string or begins with '.', add a '0'
	if output.indexOf('.') is 0 then output = '0' + output
	if output is '' then output = '0'
	# if output is end with '.', remove the '.'
	output.replace(/\.$/, '')
