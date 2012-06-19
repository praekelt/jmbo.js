fs = require 'fs'
{exec} = require 'child_process'


build = (callback) ->
    console.log 'Compiling'
    exec "coffee --compile --output lib/ src/", (err, stdout, stderr) ->
        throw err if err
        console.log 'Compiling: Done.'
        callback() if callback
        return true

minify = ->
    console.log 'Minify'
    exec 'java -jar "compiler.jar" --js lib/jmbo.js --js_output_file lib/jmbo-min.js', (err, stdout, stderr) ->
        throw err if err
        console.log 'Minify: Done.'


task 'watch', 'Watch this project for changes and compile to a single source', ->
    console.log  """Run: watchr -e 'watch(".*\.coffee") { |f| system("cake build") }'"""

task 'build-seperate', 'Compiles coffee from src/*.coffee to lib/*.js', ->
    build()

task 'build', 'Joins coffee files and compiles to a single source', ->
    files = [
        'src/main'
        'src/ui'
        'src/ui.view'
        'src/ui.stack'
        'src/ui.tab'
    ]

    console.log 'Joining'
    concat = new Array
    for file, index in files then do (file, index) ->
        console.log "Joining: #{file}.coffee"
        concat[index] = fs.readFileSync "#{file}.coffee"
        index += 1

    fs.writeFile 'src/jmbo.coffee', concat.join('\n\n'), 'utf8', (err) ->
        throw err if err
        build ->
            console.log 'Compiling: ./lib/jmbo.js'
            fs.unlink 'src/jmbo.coffee'


task 'minify', 'Minifies jmbo.js to jmbo-min.js after build', ->
    minify()