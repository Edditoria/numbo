'use strict';

import { resolve } from 'node:path';
import { exit } from 'node:process';
import { emptyDir } from 'fs-extra';

const TASK_NAME = 'clean';
const foldersToClean = Object.freeze(['bundles', 'esm', 'test']);

const FULFILLED = 'fulfilled';
const REJECTED = 'rejected';

cleanNow(TASK_NAME, foldersToClean);

/**
 * Expect to run this function using `npm run clean`.
 * @param {string} taskName  Task name to print to console.
 * @param {string[]} folders  Folders to be cleaned.
 */
async function cleanNow(taskName, folders) {
	console.log(`Starting task "${taskName}"...`);
	const timerLabel = `Finished task "${taskName}"`;
	// console.log('');
	console.time(timerLabel);

	const promises = folders.map(async (folder) => {
		const fullPath = resolve('./' + folder);
		try {
			await emptyDir(fullPath);
			return { folder, status: FULFILLED };
		} catch (error) {
			return { folder, status: REJECTED, error };
		}
	});

	/** @type {PromiseSettledResult<{ folder: string, status: string, error?: Error }>[]} */
	const results = await Promise.allSettled(promises);

	/** @type {{ folder: string, status: 'rejected', error: Error }[]} */
	const errs = [];
	for (const result of results) {
		if (result.status === REJECTED) {
			errs.push(result.reason);
		} else if (result.status === FULFILLED && result.value.status === REJECTED) {
			errs.push(result.value);
		}
	}

	if (errs.length > 0) {
		console.error('Error(s) in cleanNow():');
		for (const err of errs) {
			console.error(`- Failed folder "${err.folder}":`, err.message || err);
		}
		console.timeEnd(timerLabel);
		exit(1);
	}
	console.timeEnd(timerLabel);
}
