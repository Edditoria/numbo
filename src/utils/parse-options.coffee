normalizeLangs = (lang) ->
	return lang.replace(/\-|\_/g, '').toLowerCase()

export default (langs, options) ->
	plugin = '' # set as empty first
	template = '' # set as empty first
	otherOptions = []
	error = false
	normalizedLangs = langs.map((lang) -> normalizeLangs(lang))

	# parse each item
	for item in options
		if typeof item is 'string'
			normalizedOption = normalizeLangs(item)
			if normalizedLangs.indexOf(normalizedOption) >= 0 # the item is a language/plugin
				if plugin is '' then plugin = item
				else
					console.log 'Error: Invalid option. You have selected more than one language/plugin. Returns null'
					error = true
			else if template is ''
				switch item
					when 'default' then template = 'default'
					when 'number', 'num' then template = 'number'
					when 'check', 'cheque', 'chk', 'chq' then template = 'cheque'
					when 'amount', 'amt' then template = 'amount'
					else
						otherOptions.push(item)
			else
				otherOptions.push(item)
		else # item isnt 'string'
			console.log 'Error: Invalid option. Each option has to be a string.'
			error = true

	if template is '' then template = 'default'
	if plugin is '' then plugin = 'enUS'

	parsedOptions =
		plugin: plugin
		template: template
		otherOptions: otherOptions
		error: error
	return parsedOptions
