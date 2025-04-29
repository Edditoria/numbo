/*
 * decaffeinate suggestions:
 * DS205: Consider reworking code to avoid use of IIFEs
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/main/docs/suggestions.md
 */
export default (function (topic) {
	const content = (() => {
		switch (topic) {
			case 'startTest':
				return `\
Starting Test
=============

The following error logs may be expected (true negatives):
\
`;
			case 'summary':
				return `\

Summary
=======
\
`;
			case 'failResults':
				return `\

Fail Results
============
\
`;
			case 'testDone':
				return `\

Test Done
=========
\
`;
		}
	})();
	console.log(content);
});
