export default function (topic) {
	var content;
	content = (function () {
		switch (topic) {
			case 'startTest':
				return `Starting Test
=============

The following error logs may be expected (true negatives):
`;
			case 'summary':
				return `
Summary
=======
`;
			case 'failResults':
				return `
Fail Results
============
`;
			case 'testDone':
				return `
Test Done
=========
`;
		}
	})();
	console.log(content);
}
