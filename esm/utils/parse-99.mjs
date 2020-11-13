export default function (arr1, arr10, separator = ' ') {
	var i, lenArr1, num, results;
	// parse number to words from 0 to 99
	// 0 is usually an empty string ''
	// `arr1`: array from 0 to 9 in a language
	//   e.g. ['', One', 'Two',...'Nine']
	// `arr10`: unit [10, 20, 30,...90] in a language
	//   e.g. ['Ten', 'Twenty',...'Ninety']
	// output example: ['One', 'Two',...'Ninty-nine']
	// `separator`: usually a space ' ' (default), a hyphen '-', or an empty string ''
	lenArr1 = arr1.length;
	results = [];
	for (num = i = 0; i <= 99; num = ++i) {
		if (num < lenArr1) {
			results.push(arr1[num]);
		} else if (num % 10 === 0) {
			results.push(arr10[Math.floor(num / 10)]);
		} else {
			results.push(
				arr10[Math.floor(num / 10)] + separator + arr1[num % 10].toLowerCase()
			);
		}
	}
	return results;
}
