/**
Parse value of options.lang to Numbo standard.
@param {string} lang - e.g. 'en-US', 'en_US', 'en-us', etc.
@return {string|boolean} - Standard language code in 4 characters, e.g. 'enUS'
*/
export default function (lang) {
	var lang1, lang2, re;
	re = /^[a-z]{2}[A-Z]{2}$/g;
	// Quickly pass the validation
	if (re.test(lang)) {
		return lang;
	}
	// Remove '-' and '_'
	lang = lang.replace(/\-|\_/g, '');
	// lang.length have to be 4
	if (lang.length !== 4) {
		console.log('Error: options.lang does not meet the Numbo standard.');
		return false;
	}
	// Lowercase x 2 then uppercase x 2, e.g. enUS
	lang1 = lang.substring(0, 2).toLowerCase();
	lang2 = lang.substring(2).toUpperCase();
	return lang1 + lang2;
}
