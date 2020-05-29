###
Numbo is open source in:
https://github.com/Edditoria/numbo

under MIT license:
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

class Numbo

	tools =
		parse99: parse99
		trimWhitespace: trimWhitespace
		parseCents: parseCents
		speakByDigit: speakByDigit
		check: check
		normalize: normalize
		adjustDecimal: adjustDecimal
		splitNum: splitNum
		splitInt: splitInt
	tools:
		trimWhitespace: tools.trimWhitespace
		parse99: tools.parse99
		parseCent: tools.parseCents #todo to be depreciated
		parseCents: tools.parseCents #todo to be depreciated
		speakByDigit: tools.speakByDigit
		check: tools.check
		validate: tools.check
		normalize: tools.normalize
		normalise: tools.normalize
		adjustDecimal: tools.adjustDecimal
		splitNum: tools.splitNum
		splitInt: tools.splitInt

	convert_enUS = enUS
	enUS: convert_enUS


	convert: (input, options...) ->
		# `input` can be string or number
		# `options` can be language ('zhTW') and style ('number', 'amount' or 'cheque')
		if options.length is 0 # not provide any option
			convert_enUS(input)
		else
			zeroCent = false #todo: temp setup
			parsedOptions = parseOptions(options)
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
				@[parsedOptions.plugin](input, otherOptions.template, zeroCent) #todo: temp setup for zeroCent


numbo = new Numbo()

export default numbo
