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
import parseType from './utils/parse-type.coffee'
import speakByDigit from './utils/speak-by-digit.coffee'
import check from './utils/check.coffee'
import normalize from './utils/normalize.coffee'
import adjustDecimal from './utils/adjust-decimal.coffee'
import splitNum from './utils/split-num.coffee'
import splitInt from './utils/split-int.coffee'

# import parseOptions from './utils/parse-options.coffee'
import parseLang from './utils/parse-lang.coffee'
import enUS from './en-us.coffee'
import zhTW from './zh-tw.coffee'
import zhCN from './zh-cn.coffee'

utils =
	trimWhitespace: trimWhitespace
	parse99: parse99
	parseCent: parseCents #todo to be depreciated
	parseCents: parseCents #todo to be depreciated
	parseType: parseType
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

defaultOptions =
	lang: 'enUS'
	type: 'number'

setOptions = (options) ->
	Object.assign(@options, options)
	return @options

resetOptions = () ->
	@options = Object.assign({}, defaultOptions)
	return @options

###
Convert numerical input to a specific language.
It will pass the whole option object to another modules for further processing.
@param {string|number} input - The key input being converted, e.g. '123.45'.
@param {Object|null} options - Includes lang, type and others.
@return {string} - Final output of numbo.
###
convert = (input, options) ->
	# Clone this.options, then override it using options
	oneTimeOptions = Object.assign({}, @options, options)
	oneTimeOptions.lang = parseLang(oneTimeOptions.lang)
	if oneTimeOptions.lang is false
		return null
	if !langs[oneTimeOptions.lang]?
		console.log 'Error: Cannot find the lang function:', options.lang
		return null
	return langs[oneTimeOptions.lang](input, oneTimeOptions)


class Numbo
	constructor: (options) ->
		if !options? # options == null
			@options = defaultOptions
		else
			@options = Object.assign({}, defaultOptions, options)

# Public methods
Numbo::convert = convert
Numbo::utils = utils
Numbo::enUS = enUS
Numbo::zhTW = zhTW
Numbo::zhCN = zhCN

Numbo::getDefaultOptions = () -> return defaultOptions
Numbo::getOptions = () -> return @options
Numbo::setOptions = setOptions
Numbo::resetOptions = resetOptions

export default Numbo
