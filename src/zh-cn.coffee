###*
@module zhCN
@file Convert number to Simplified Chinese (zh-CN) as part of Numbo JS library.

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
import speakByDigit from './utils/speak-by-digit.coffee'
import splitInt from './utils/split-int.coffee'
import parseCents from './utils/parse-cents.coffee'

# note to 0:
# - 《出版物上数字用法》规定：一个数字用作计量时，其中“0”的汉字书写形式为“零”；
# - 而当用作编号时，“0”的汉字书写形式为“〇”
# - number.convert(num, 'zhCN', 'number') is a number for measuring
# #todo: 'numbering' of using '〇' instead of '零'.

###* @type {Array.<string>} - [0..9] in full-stroke style. ###
n1 = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖']
###* @type {Array.<string>} - [0..9] in normal-stroke style. ###
n1Simple = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九']
###* @type {Array.<string>} - ['', 10, 100, 1000] in full-stroke style. ###
n10 = ['', '拾', '佰', '仟']
###* @type {Array.<string>} - ['', 10, 100, 1000] in normal-stroke style. ###
n10Simple = ['', '十', '百', '千']
###*
@type {Array.<string>} Names for large numbers: 1, 1 0000 , 1 0000 0000 ...
	Quote: 万万为亿，万亿为兆。
###
nLarge = [
	'', '万', '亿', '兆', '京'
	'垓', '秭', '穰', '沟', '涧', '正', '载'
]

###*
Convert number ('1'..'9999') to Chinese.
@param {string} str - Expect '1'..'9999'
@param {boolean|null} [isSimple=true] - Result in simple-stroke style, e.g. '一' instead of '壹'.
@return {string}
###
speak9999 = (str, isSimple = true) ->
	# may contain double '零'/'〇', but not going to fix it here
	speakN1 = if isSimple then n1Simple else n1
	speakN10 = if isSimple then n10Simple else n10
	times = str.length - 1
	output = ''
	for num in [0..times]
		eachNum = +str[num]
		unit = if eachNum is 0 then '' else speakN10[times - num]
		output += speakN1[eachNum] + unit
	if output is '零零零零' then output = '零'
	else output = output.replace(/\零+$/g, '') # remove tailing '零'
	output

###*
Convert integer part of Numbo input to Chinese.
It splits str into array by every 4 characters, then speak9999() one-by-one.
Work for speakNum() and speakAmt().
@param {string} str
@param {boolean|null} isSimple - Will be brought forward to speak9999().
@return {string}
###
speakInt = (str, isSimple = true) ->
	if str is '0' then '零'
	else
		strArr = splitInt(str, 4)
		times = strArr.length - 1
		output = ''
		for item, num in strArr
			speakItem = speak9999(item, isSimple) # item = 0 will return '零'
			if num is 0
				# the first item, in case of 10 to 19, need to remove 一, 壹 and 零
				# e.g. 12 in 12,0000,0000 , or simply 18 in 18
				itemNum = parseInt(item, 10)
				if itemNum > 9 and itemNum < 20
					speakItem = speakItem.replace(/^[\一\壹]|\零/g, '')
			unit = if speakItem is '零' then '' else nLarge[times - num]
			output += speakItem + unit
		output
			.replace(/\零+$/g, '') # remove tailing zero '零'
			.replace(/\零+/g, '零') # remove double '零'

###*
Convert Numbo input to Chinese in China PRC.
As one of two main functions in zhCN,
it runs when options.type is 'number'.
@param {string} str - Numbo input after parsing.
@return {string} - Final answer of Numbo.
###
speakNum = (str) ->
	strSplited = splitNum(str)
	int = strSplited[0]
	dec = strSplited[1]
	dot = if dec is '' then '' else '点'
	speakInt(int, true) + dot + speakByDigit(dec, n1Simple, '')

###*
Convert Numbo input to Chinese in China PRC.
As one of two main functions in zhCN,
it runs when options.type is 'amount' or 'cheque'.
@param {string} str - Numbo input after parsing.
@param {string} options - Either 'amount' or 'cheque'
@return {string} - Final answer of Numbo.
###
speakAmt = (str, options = 'cheque') ->
	str = adjustDecimal(str, 'ceil', 2)
	strSplited = splitNum(str)
	int = strSplited[0] # remark: zero will return '0' (string)
	dec = +parseCents(strSplited[1])
	if int is '0' and dec is 0
		'零元'
	else
		isSimple = if options is 'cheque' then false else true
		dollar =
			if int is '0' then ''
			else if int is '2' and options isnt 'cheque' then '两元'
			else speakInt(int, isSimple) + '元'
		cent =
			if dec is 0 # remark: zero will return ''
				if options is 'cheque' then '整' else ''
			else
				speakN1 = if isSimple then n1Simple else n1
				dp1 = Math.floor(dec/10)
				dp2 = dec % 10
				cent1 =
					if dp1 is 0 then ''
					else if dp1 is 2 and options isnt 'cheque' then '两角'
					else speakN1[dp1] + '角'
				cent2 =
					if dp2 is 0 then ''
					else if dp2 is 2 and options isnt 'cheque' then '两分'
					else speakN1[dp2] + '分'
				cent = cent1 + cent2
		dollar + cent


###*
Convert Numbo input to Chinese in China PRC.
This zhCN module reacts to numbo.convert(input, options) when type is zh-CN.
Or directly import it as a function.
@param {string|number} input - Numbo input 'nnnnnnn.dddd', e.g. '123.45'.
@param {Object|null} options - The Numbo options object.
@return {string|null} - e.g. '一百二十三点四五', or null if detects error.
###
export default (input, options = { type: 'number' }) ->
	if input is '' then return null
	if input is '1e+100' then return 'Ding! One Google... Oops... One Googol!!'
	if check(input) is false
		console.log 'Error: Invalid input value. Return null'
		return null
	# else
	input = normalize(input) # input becomes a string
	switch options.type
		when null, 'number', 'num' then return speakNum(input)
		when 'cheque', 'check', 'chk', 'chq' then return speakAmt(input, 'cheque')
		when 'amount', 'amt' then return speakAmt(input, 'amount')
		else
			console.log 'Error: Option in zhCN is not valid'
			return null
