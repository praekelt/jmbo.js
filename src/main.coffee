
# namespace helper function.
window.namespace = (target, name, block) ->

  #log name # name is the function.
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top = target


  target = target[item] or= {} for item in name.split '.'
  block target, top

# quick log
window.log = (x...) ->
  if (x.length == 1)
    x = x[0]
  console.log x