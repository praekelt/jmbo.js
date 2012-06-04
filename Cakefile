fs = require 'fs'
{exec} = require 'child_process'



build = (callback) ->
    console.log "Building src/ to /lib"
    exec "coffee --compile --output lib/ src/", (err, stdout, stderr) ->
        throw err if err
        console.log 'Building done.'
        callback() if callback
        return true



task 'build', 'Build projects from src/*.coffee to lib/*.js', ->
    build()


task 'concat+build', 'Contacts *.coffee and then builds them', ->
    #
    concat = new Array
    index = 0
    # list files in src/*.coffee
    files = fs.readdirSync 'src/'
    for file in files then do (file) ->
        fileparts = file.split '.'
        if fileparts[fileparts.length - 1] == 'coffee'
            console.log "Adding: #{file}"
            concat[index] = fs.readFileSync "src/#{file}"
            index += 1


    fs.writeFile 'src/jmbo.coffee', concat.join('\n\n'), 'utf8', (err) ->
        throw err if err
        build ->
            console.log 'Built in lib/jmbo.js'
            fs.unlink 'src/jmbo.coffee'

    #fs.unlinkSync 'lib/concat.coffee'
    #     throw err in err
 #            exec 'coffee --compile lib/concat.coffee', (err, stdout, stderr) ->
 #                throw err if err
 #                console.log stdout + stderr
 #                fs.unlink 'lib/concat.coffee', (err) ->
 #                    throw err if err
 #                    console.log 'Done.'
 # 