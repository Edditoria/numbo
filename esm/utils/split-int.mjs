export default function (int, digit = 3) {
	var intTail, len, output, times;
	// split `int` (an integer) into ['n', 'nnn', 'nnn'...], depends on `digit`
	if (typeof int !== 'string') {
		int = int.toString(); // for safety
	}
	output = [];
	times = Math.ceil(int.length / digit); // at least 1
	while (times) {
		len = int.length;
		intTail = int.substring(len - digit, len); // cut the tail
		int = int.substring(0, len - digit); // the remaining `int`
		output.unshift(intTail);
		times--;
	}
	return output;
}
