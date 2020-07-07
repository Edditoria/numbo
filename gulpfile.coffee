gulp = require 'gulp'
coffee = require 'gulp-coffee'
prettier = require 'gulp-prettier'
replace = require 'gulp-replace'
rename = require 'gulp-rename'

srcGlobs = [
	'src/**/*.coffee'
	'!src/test/**'
]
testGlobs = [
	'src/test/**/*.coffee'
	'!src/test/test-bundles.coffee'
]

# $1: Extension name to be replaced; $2: Two characters "';" to be reserved
regex = /(.coffee)(['"];\s*)$/gm
extname = '.mjs'

buildESM = (cb) ->
	gulp.src(srcGlobs)
		.pipe coffee()
		.pipe prettier(
			editorconfig: true
			singleQuote: true
		)
		# Replace extension name from .coffee to .mjs in import statements
		.pipe replace(regex, extname + '$2')
		.pipe rename({ extname: extname })
		.pipe gulp.dest('esm/')
	cb()
	return

buildTestESM = (cb) ->
	gulp.src(testGlobs)
		.pipe coffee()
		.pipe prettier(
			editorconfig: true
			singleQuote: true
		)
		.pipe replace(regex, extname + '$2')
		.pipe rename({ extname: extname })
		.pipe gulp.dest('test/')
	cb()
	return

exports.default = gulp.parallel(buildESM, buildTestESM)
exports.buildESM = buildESM
exports.buildTestESM = buildTestESM
