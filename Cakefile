{exec} = require 'child_process'


task 'build', 'Build projects from src/*.coffee to lib/*.js', ->
    exec 'coffee --compile --output lib/ src/', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
        console.log 'Finished.'


task 'build+min', '', ->
    console.log 'Pew'