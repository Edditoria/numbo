###*
Parse decimals of Numbo input to 2-digit numerical string.
e.g. '015' becomes '02' (2 cents), '5' becomes '50' (50 cents)
@param {string} dec - The decimals of the Numbo input.
@param {string}
###
export default (dec) ->
	return (dec + '000').slice(0,2)
