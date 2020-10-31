###*
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

# 0 to 9
n1 = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖']
n1Simple = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九']
# units for digits (i.e. 1, 10, 100, 1000)
n10 = ['', '拾', '佰', '仟']
n10Simple = ['', '十', '百', '千']
# units for large number (i.e. 1, 1 0000 , 1 0000 0000 ...)
# 万万为亿，万亿为兆
nLarge = [
	'', '万', '亿', '兆', '京'
	'垓', '秭', '穰', '沟', '涧', '正', '载'
]

speak9999 = (str, isSimple = true) ->
	# expect a string within 4 digit
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

speakInt = (str, isSimple = true) =>
	# split the str into array by every 4 characters
	# then speak9999() one by one
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

# Main function 1 of 2
speakNum = (str) ->
	strSplited = splitNum(str)
	int = strSplited[0]
	dec = strSplited[1]
	dot = if dec is '' then '' else '点'
	speakInt(int, true) + dot + speakByDigit(dec, n1Simple, '')

# Main function 2 of 2
speakAmt = (str, options = 'cheque') ->
	str = adjustDecimal(str, 'ceil', 2)
	strSplited = splitNum(str)
	int = strSplited[0] # remark: zero will return '0' (string)
	dec = +((strSplited[1] + '0').slice(0,2)) #todo: pack into parseCents
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


export default (input, options = 'default') ->

	main = (input, options = 'default') ->
		# input is a string or a number
		# options should be a string
		if input is '' then null
		else if input is '1e+100' then 'Ding! One Google... Oops... One Googol!!'
		else
			if check(input) is false
				console.log 'Error: Invalid input value. Return null'
				null
			else
				input = normalize(input) # input becomes a string
				input
				switch options
					when 'default', 'number', 'num' then speakNum(input)
					when 'cheque', 'check', 'chk', 'chq' then speakAmt(input, 'cheque')
					when 'amount', 'amt' then speakAmt(input, 'amount')
					else
						console.log 'Error: Option in zhCN is not valid'
						null
	main(input, options)
