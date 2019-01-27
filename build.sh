#!/usr/bin/env bash

echo "Compile coffeescript files..."
coffee -o ./lib/ -c ./src/*.coffee
coffee --transpile -o ./dist/ -c ./src/*.coffee
coffee --transpile -o ./docs/assets/js -c ./src/*.coffee
coffee -o ./test/ -c ./src/test/*.coffee
echo "Compile finish."
