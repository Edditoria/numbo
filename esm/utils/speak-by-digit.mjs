export default function (str, n1, separator = ' ') {
	var i, item, len, output;
	// match every characters of `str` to `n1[str]` one-by-one
	// the 1st arg should a string contains numbers only (e.g. '000123')
	// return a string (e.g. 'zero zero zero one two three')
	if (typeof str === 'string' && str.search(/\D/g) < 0) {
		output = [];
		for (i = 0, len = str.length; i < len; i++) {
			item = str[i];
			output.push(n1[+item]);
		}
		return output.join(separator);
	} else {
		console.log('Error: Invalid argument of speakByDigit()');
		return null;
	}
}
