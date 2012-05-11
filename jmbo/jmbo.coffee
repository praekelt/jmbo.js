
# namespace helper function.
window.namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

# quick log
window.l = (x...) ->
  if (x.length == 1)
    x = x[0]
  console.log x