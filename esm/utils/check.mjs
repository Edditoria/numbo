export default function (input, characters = '') {
	var acceptRegex, commaAfterDot, dotCount, illegalStr, inputStr, result;
	// check if there are only:
	// - contains numbers and comma
	// - beginning with any of '$', '+', '-'
	// - only one dot
	// - no ',' after dot
	// accepts additional characters as 2nd argument #todo
	// returns true or false
	result = false;
	inputStr = input.toString();
	acceptRegex = /^[\+\-\$]*[\d\.\,]*|[\d\.\,]*/g;
	illegalStr = inputStr.replace(acceptRegex, '');
	dotCount = (inputStr.match(/\./g) || []).length; // count string occurrence in string
	commaAfterDot = inputStr.indexOf(',', inputStr.indexOf('.')) > 0;
	if (illegalStr === '' && dotCount < 2 && !commaAfterDot) {
		result = true;
	}
	return result;
}
