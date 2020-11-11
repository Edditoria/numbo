###*
@module enUS
@file Convert number to English (en-US) as part of Numbo JS library.

Numbo is open source in:
https://github.com/Edditoria/numbo

@author Edditoria
@license MIT
Code released under the MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE.txt
###

import check from './utils/check.coffee'
import normalize from './utils/normalize.coffee'
import adjustDecimal from './utils/adjust-decimal.coffee'
import splitNum from './utils/split-num.coffee'
import splitInt from './utils/split-int.coffee'
import speakByDigit from './utils/speak-by-digit.coffee'
import parse99 from './utils/parse-99.coffee'
import parseCents from './utils/parse-cents.coffee'
import trimWhitespace from './utils/trim-whitespace.coffee'

###* @type {Options} ###
defaultOptions =
	type: 'number'
	zeroCent: false

n1 = [
	'' # zero
	'One', 'Two', 'Three', 'Four', 'Five'
	'Six', 'Seven', 'Eight', 'Nine', 'Ten'
	'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen'
	'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
]
n1withZero = [
	'Zero'
	'One', 'Two', 'Three', 'Four', 'Five'
	'Six', 'Seven', 'Eight', 'Nine', 'Ten'
	'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen'
	'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
]
n10 = [
	'' # zero
	'Ten', 'Twenty', 'Thirty', 'Forty', 'Fifty'
	'Sixty', 'Seventy', 'Eighty', 'Ninety'
]
n1000 = [
	'', 'Thousand', 'Million', 'Billion', 'Trillion'
	'Quadrillion', 'Quintillion', 'Sextillion', 'Septillion', 'Octillion'
	'Nonillion', 'Decillion', 'Undecillion', 'Duodecillion', 'Tredecillion'
	'Quattuordecillion', 'Quindecillion', 'Sexdecillion', 'Septendecillion', 'Octodecillion'
	'Novemdecillion', 'Vigintillion'
]
###* @type {Array.<string>} Basically ['', One', 'Two'..'Ninety-nine'] ###
n99 = parse99(n1, n10, '-')

###*
Convert number (1..999) to English.
Work for speakInt().
@param {number} num - Expect an integer 1..999
@param {boolean|null} [addAnd=true]
@return {string}
###
speak999 = (num, addAnd = true) ->
	if num <=99 then n99[num]
	else if num % 100 is 0
		n1[Math.floor(num/100)] + ' Hundred'
	else
		d100 = Math.floor(num/100)
		hundred = if addAnd then ' Hundred and ' else ' Hundred '
		output = n1[d100] + hundred + n99[num % 100]

###*
Convert integer part of Numbo input to English.
Work for speakNum() and speakAmt().
@param {Array} numArr - e.g. [12, 345, 678].
@param {boolean|null} [addAdd=true] - Will be brought forward to speak999().
@return {string}
###
speakInt = (numArr, addAnd = true) ->
	output = []
	times = numArr.length
	for item, num in numArr
		times--
		if item isnt '000'
			unit = ' ' + n1000[times]
			item = speak999(parseInt(item, 10), addAnd)
			output.push item + unit
	trimWhitespace(output.join(' '))

###*
Convert Numbo input to English.
As one of two main functions in enUS,
it runs when options.type is 'number'.
@param {string} str - Numbo input after parsing.
@return {string} - Final answer of Numbo.
###
speakNum = (str) ->
	if str is '0' then 'zero'
	else if str is '1' then 'one' # faster
	else
		strSplited = splitNum(str)
		intArr = splitInt(strSplited[0])
		int = speakInt(intArr)
		if int is '' then int = 'zero'
		dec =
			if strSplited[1] is '' then ''
			else ' point ' + speakByDigit(strSplited[1], n1withZero, ' ')
		(int + dec).toLowerCase()

###*
Convert Numbo input to English.
As one of two main functions in enUS,
it runs when options.type is 'amount' or 'cheque'.
@param {string} str - Numbo input after parsing.
@param {type} type - Either 'amount' or 'cheque':
	- 'amount': some dollars and some cents, or
	- 'cheque': Some Dollars and Some Cents Only.
@param {boolean} zeroCent - zeroCent in Numbo Options.
@return Final answer of Numbo.
###
speakAmt = (str, type, zeroCent) ->
	if str is '0' then output = 'Null'
	else
		dollarUnit = ['Dollar', 'Dollars']
		centUnit = ['Cent', 'Cents']
		# Math.ceil to 2 decimal place
		str = adjustDecimal(str, 'ceil', 2)
		# parse the `str`
		strSplited = splitNum(str)
		# parse dollars
		intArr = splitInt(strSplited[0])
		int = speakInt(intArr, false) # no 'and'
		dollars =
			if int is '' then ''
			else if int is 'One' then ' ' + dollarUnit[0]
			else ' ' + dollarUnit[1]
		# parse cents:
		# 1. strSplited[1]
		# 2. parseCents()
		# 3. +dec
		# 4. n99()
		# remark: n99[0] returns ''
		dec = n99[+parseCents(strSplited[1])]
		cents =
			if dec is '' and int is '' then 'Null'
			else if dec is '' then 'No Cent'
			else if dec is 'One' then ' Cent'
			else ' Cents'
		# put together
		andWord =
			if dollars is '' then ''
			else ' and '
		output = int + dollars + andWord + dec + cents
	# adjust the output according to `type`
	output =
		if type is 'cheque'
			if output is 'Null'
				'Null'
			else
				output + ' Only'
		else if type is 'amount'
			output
				.replace(' and No Cent', '')
				.toLowerCase()
		else
			console.log 'Error: Option in speakAmt() is invalid.'
			output = null
	if zeroCent is true then output = output.replace('and No Cent', 'and Zero Cent')
	output


###*
Convert Numbo input to English.
This enUS module reacts to numbo.convert(input, options) when type is en-US.
Or directly import it as a function.
@param {string|number} input - Numbo input 'nnnnnnn.dddd', e.g. '123.45'.
@param {Object|null} options - The Numbo options object.
@return {string|null} - e.g. 'one hundred point two three', or null if detects error.
###
export default (input, options = defaultOptions) ->
	if input is '' then return null
	if input is '1e+100' then return 'Ding! One Google... Oops... One Googol!!'
	if check(input) is false
		console.log 'Error: Invalid input value. Return null'
		return null
	# else
	input = normalize(input) # input must become a string
	switch options.type
		when null, 'number', 'num'
			return speakNum(input)
		when 'cheque', 'check', 'chk', 'chq'
			# zeroCent only accepts true. All other values are false.
			zeroCent = if options.zeroCent is true then true else false
			return speakAmt(input, 'cheque', zeroCent)
		when 'amount', 'amt'
			return speakAmt(input, 'amount', false)
		else
			console.log 'Error: option.type in enUS is not valid'
			return null
