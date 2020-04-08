export default (str, type = 'ceil', dp = 2) ->
	# To adjust `input` to `dp` decimal place, e.g. 123.4567 becomes 123.46
	# - `str` should be a string e.g. '123', '123.45'
	# - `type` accepts 'ceil' (default), 'floor' or 'round'
	# - `dp` should be a number between 0 to 4 (default is 2)
	# To avoid errors, do check() and normalize() before adjustDecimal()
	if typeof str isnt 'string' then str = str.toString() # for safety
	dotIndex = str.indexOf('.')
	if dotIndex is -1 then return str
	# check args
	if type isnt 'ceil' and type isnt 'floor' and type isnt 'round'
		type = 'ceil'
		console.log 'Error: type in adjustDecimal() is invalid. Use the default option (Math.ceil)'
	if typeof dp isnt 'number' or dp < 0
		dp = 2
		console.log 'Error: dp in adjustDecimal() is invalid. Use the default option (adjust to 2 decimal place)'
	# functions to carry digits
	parseDec = (dec, type, dp) ->
		# return '.nnnn' or '1'
		dec = '0.' + dec
		# do dec * 100, then Math[type]
		dec = Math[type](+(dec + 'e+' + dp))
		# do dec / 100
		dec = +(dec + 'e-' + dp) # 1 or 0 or 0.nnnn
		if dec is 0 then ''
		else if dec is 1 then '1'
		else (dec + '').replace(/^0/g, '') # '.nnnn'
	carryInt = (int) ->
		len = int.length
		if len < 16
			+int + 1 + ''
		else
			intArr = int.split('')
			index = len
			isCarry = true
			while index and isCarry
				index--
				thisChar = +intArr[index] + 1 + ''
				if thisChar is '10'
					thisChar = '0'
					# isCarry = true
				else
					isCarry = false
				intArr[index] = thisChar
			if isCarry then intArr.unshift('1')
			intArr.join('')
	if type is 'ceil' or type is 'round'
		# dotIndex = str.indexOf('.') is ready for use
		int = str.slice(0, dotIndex)
		dec = str.slice(dotIndex + 1)
		dec = parseDec(dec, type, dp)
		if dec is '1'
			dec = ''
			int = carryInt(int)
		int + dec
	else if type is 'floor'
		int = str.slice(0, dotIndex)
		dec = str.slice(dotIndex, dotIndex + dp + 1)
		if +dec is 0 then dec = ''
		int + dec
	else
		console.log 'Error: Unknown error in tools.adjustDecimal()'
		str
