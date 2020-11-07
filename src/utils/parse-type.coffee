###*
Parse value of options.type to Numbo standard.
@param {string} type - Alias from user, e.g. 'num', 'amt', 'chk'.
@return {string|boolean} - Return asap. Either 'number', 'amount' or 'cheque', or false.
###
export default (type) ->
	switch type
		when null, 'number', 'num' then return 'number'
		when 'cheque', 'check', 'chk', 'chq' then return 'cheque'
		when 'amount', 'amt' then return 'amount'
	console.log 'Error: option.type in enUS is not valid'
	return false
