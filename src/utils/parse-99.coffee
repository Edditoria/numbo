export default (arr1, arr10, separator = ' ') ->
	# parse number to words from 0 to 99
	# 0 is usually an empty string ''
	# `arr1`: array from 0 to 9 in a language
	#   e.g. ['', One', 'Two',...'Nine']
	# `arr10`: unit [10, 20, 30,...90] in a language
	#   e.g. ['Ten', 'Twenty',...'Ninety']
	# output example: ['One', 'Two',...'Ninty-nine']
	# `separator`: usually a space ' ' (default), a hyphen '-', or an empty string ''
	lenArr1 = arr1.length
	for num in [0..99]
		if num < lenArr1
			arr1[num]
		else if num % 10 is 0
			arr10[Math.floor(num/10)]
		else
			arr10[Math.floor(num/10)] + separator + arr1[num % 10].toLowerCase()
