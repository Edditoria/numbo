/**
Parse value of options.type to Numbo standard.
@param {string} type - Alias from user, e.g. 'num', 'amt', 'chk'.
@return {string|boolean} - Return asap. Either 'number', 'amount' or 'cheque', or false.
*/
export default function (type) {
	switch (type) {
		case null:
		case 'number':
		case 'num':
			return 'number';
		case 'cheque':
		case 'check':
		case 'chk':
		case 'chq':
			return 'cheque';
		case 'amount':
		case 'amt':
			return 'amount';
	}
	console.log('Error: option.type in enUS is not valid');
	return false;
}
