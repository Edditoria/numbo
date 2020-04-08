export default (str, option = 'ceil') ->
	console.log 'Depreciated: Parse the whole string using adjustDecimal() instead' #todo
	# slice first 3 characters, round it, then return 2-digit number
	# e.g. '015' becomes '02' (2 cents), '5' becomes '50' (50 cents)
	# `option` supports 'ceil', 'round', 'floor'
	str3dp = (str + '000').slice(0,3)
	mathOption =
		switch option
			when 'round' then 'round'
			when 'floor' then 'floor'
			when 'ceil' then 'ceil'
			else
				console.log 'Error: Option in parseCents() is invalid. Use the default option (Math.ceil)'
				'ceil'
	Math[mathOption](parseInt(str3dp, 10) / 10)
