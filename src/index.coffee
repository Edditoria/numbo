###*
Numbo is a Javascript library to convert number and monetary amount
to written text in multiple languages.
Also helpful for writing cheques (checks). Supports English, and 支援中文.

Numbo is open source in:
https://github.com/Edditoria/numbo

@module Numbo
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

import parseLang from './utils/parse-lang.coffee'
import enUS from './en-us.coffee'
import zhTW from './zh-tw.coffee'
import zhCN from './zh-cn.coffee'

###*
@typedef {Object} Options
Numbo options are widely used as argument in modules.
It is designed to bring forward to vary modules and functions.
All property are optional. Defaults are:
@property {?string} lang - Numbo bundled modules: 'enUS', 'zhTW' and 'zhCN'.
@property {?string} type - 'number', 'amount', 'cheque' and their aliases.
@property {?boolean} zeroCent - Useful when cheque amount is an integer.
	True to display "and zero cent" instead of "and no cent".
###

# Collections of utils and langs
# ==============================

utils =
	trimWhitespace: trimWhitespace
	parse99: parse99
	parseCent: parseCents
	parseCents: parseCents
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

# Operating Options
# =================

###* @type {Options} ###
defaultOptions =
	lang: 'enUS'
	type: 'number'

setOptions = (options) ->
	Object.assign(@options, options)
	return @options

resetOptions = () ->
	@options = Object.assign({}, defaultOptions)
	return @options

###*
Convert is named for Numbo.convert() method.
It actually passes numerical string and options to a language module.
@param {string|number} input - The key input being converted, e.g. '123.45'.
@param {Options|null} options
@return {string} - Final output of Numbo.
###
convert = (input, options) ->
	# Clone this.options, then override it using options arg
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
