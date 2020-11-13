export default function (str, type = 'ceil', dp = 2) {
	var carryInt, dec, dotIndex, int, parseDec;
	// To adjust `input` to `dp` decimal place, e.g. 123.4567 becomes 123.46
	// - `str` should be a string e.g. '123', '123.45'
	// - `type` accepts 'ceil' (default), 'floor' or 'round'
	// - `dp` should be a number between 0 to 4 (default is 2)
	// To avoid errors, do check() and normalize() before adjustDecimal()
	if (typeof str !== 'string') {
		str = str.toString(); // for safety
	}
	dotIndex = str.indexOf('.');
	if (dotIndex === -1) {
		return str;
	}
	// check args
	if (type !== 'ceil' && type !== 'floor' && type !== 'round') {
		type = 'ceil';
		console.log(
			'Error: type in adjustDecimal() is invalid. Use the default option (Math.ceil)'
		);
	}
	if (typeof dp !== 'number' || dp < 0) {
		dp = 2;
		console.log(
			'Error: dp in adjustDecimal() is invalid. Use the default option (adjust to 2 decimal place)'
		);
	}
	// functions to carry digits
	parseDec = function (dec, type, dp) {
		// return '.nnnn' or '1'
		dec = '0.' + dec;
		// do dec * 100, then Math[type]
		dec = Math[type](+(dec + 'e+' + dp));
		// do dec / 100
		dec = +(dec + 'e-' + dp); // 1 or 0 or 0.nnnn
		if (dec === 0) {
			return '';
		} else if (dec === 1) {
			return '1';
		} else {
			return (dec + '').replace(/^0/g, ''); // '.nnnn'
		}
	};
	carryInt = function (int) {
		var index, intArr, isCarry, len, thisChar;
		len = int.length;
		if (len < 16) {
			return +int + 1 + '';
		} else {
			intArr = int.split('');
			index = len;
			isCarry = true;
			while (index && isCarry) {
				index--;
				thisChar = +intArr[index] + 1 + '';
				if (thisChar === '10') {
					thisChar = '0';
				} else {
					// isCarry = true
					isCarry = false;
				}
				intArr[index] = thisChar;
			}
			if (isCarry) {
				intArr.unshift('1');
			}
			return intArr.join('');
		}
	};
	if (type === 'ceil' || type === 'round') {
		// dotIndex = str.indexOf('.') is ready for use
		int = str.slice(0, dotIndex);
		dec = str.slice(dotIndex + 1);
		dec = parseDec(dec, type, dp);
		if (dec === '1') {
			dec = '';
			int = carryInt(int);
		}
		return int + dec;
	} else if (type === 'floor') {
		int = str.slice(0, dotIndex);
		dec = str.slice(dotIndex, dotIndex + dp + 1);
		if (+dec === 0) {
			dec = '';
		}
		return int + dec;
	} else {
		console.log('Error: Unknown error in adjustDecimal()');
		return str;
	}
}
