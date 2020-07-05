export default (topic) ->
	content = switch topic
		when 'startTest' then """
			Starting Test
			=============

			The following error logs may be expected (true negatives):

			"""
		when 'summary' then """

			Summary
			=======

			"""
		when 'failResults' then """

			Fail Results
			============

		"""
		when 'testDone' then """

			Test Done
			=========

		"""
	console.log content
	return
