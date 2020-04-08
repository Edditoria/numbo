export default (input, characters = '') ->
	# check if there are only:
	# - contains numbers and comma
	# - beginning with any of '$', '+', '-'
	# - only one dot
	# - no ',' after dot
	# accepts additional characters as 2nd argument #todo
	# returns true or false
	result = false
	inputStr = input.toString()
	acceptRegex = /^[\+\-\$]*[\d\.\,]*|[\d\.\,]*/g
	illegalStr = inputStr.replace(acceptRegex, '')
	dotCount = (inputStr.match(/\./g) or []).length # count string occurrence in string
	commaAfterDot = inputStr.indexOf(',', inputStr.indexOf('.')) > 0
	if illegalStr is '' and dotCount < 2 and !commaAfterDot then result = true
	result
