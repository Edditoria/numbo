###*
Numbo is a Javascript library to convert number and monetary amount
to written text in multiple languages.
Also helpful for writing cheques (checks). Supports English, and 支援中文.

Numbo is open source in:
https://github.com/Edditoria/numbo

@file The main entry of Numbo library.
@author Edditoria
@license MIT
Code released under the MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE.txt
###

import parse99 from './utils/parse-99.coffee'
import trimWhitespace from './utils/trim-whitespace.coffee'
import parseCents from './utils/parse-cents.coffee'
import speakByDigit from './utils/speak-by-digit.coffee'
import check from './utils/check.coffee'
import normalize from './utils/normalize.coffee'
import adjustDecimal from './utils/adjust-decimal.coffee'
import splitNum from './utils/split-num.coffee'
import splitInt from './utils/split-int.coffee'

import parseOptions from './utils/parse-options.coffee'
import enUS from './en-us.coffee'
import zhTW from './zh-tw.coffee'
import zhCN from './zh-cn.coffee'

utils =
	trimWhitespace: trimWhitespace
	parse99: parse99
	parseCent: parseCents #todo to be depreciated
	parseCents: parseCents #todo to be depreciated
	speakByDigit: speakByDigit
	check: check
	validate: check
	normalize: normalize
	normalise: normalize
	adjustDecimal: adjustDecimal
	splitNum: splitNum
	splitInt: splitInt

langs =
	enUS: enUS
	zhTW: zhTW
	zhCN: zhCN

langNames = ['enUS', 'zhTW', 'zhCN']
convert = (input, options...) ->
	# `input` can be string or number
	# `options` can be language ('zhTW') and style ('number', 'amount' or 'cheque')
	if options.length is 0 # not provide any option
		langs.enUS(input)
	else
		zeroCent = false #todo: temp setup
		parsedOptions = parseOptions(langNames, options)
		otherOptions = parsedOptions.otherOptions

		# Skip and return null if any error occurs
		if parsedOptions.error is true then null
		# Currently, otherOptions is not allowed yet.
		else if otherOptions.length > 0 and otherOptions.toString() isnt 'zeroCent'
			#todo: the condition about 'zeroCent' should be done in parseOption()
			console.log 'Error: Invalid option. Possibly more than one template is selected. Or, some option(s) are parsed into [otherOptions], but it is not allowed in current version yet.'
			null
		else
			# execute convert() according to options provided
			if otherOptions.toString() is 'zeroCent'
				#todo: should be done in parseOption()
				zeroCent = true
			langs[parsedOptions.plugin](input, parsedOptions.template, zeroCent) #todo: temp setup for zeroCent


class Numbo

# Public methods
Numbo::convert = convert
Numbo::tools = utils
Numbo::enUS = enUS
Numbo::zhTW = zhTW
Numbo::zhCN = zhCN

numbo = new Numbo()

export default numbo
