export default function (input) {
	var output;
	// `input` should be a string or number of positive number (integer or float), e.g. 'nnnnnnnn.dddd'
	// return an array ['nnnnnnnn', 'dddd']
	// if there is no decimal place, will return ['nnnn', '']
	if (typeof input !== 'string') {
		input = input.toString(); // for safety
	}
	if (input.indexOf('.') === -1) {
		output = [input, ''];
	} else {
		output = input.split('.');
	}
	if (output[0] === '') {
		output[0] = '0';
	}
	return output;
}
