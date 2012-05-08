jmbo-apps

JMBO-apps is a JavaScript framework (Argh!) built in CoffeeScript, which requires
Backbone.js + Underscore.js + Zepto.js.

The idea is that jmbo-apps will improve the speed and give you a somewhat flexible
structure to single page apps. By single page we means apps that don't reload.


We currently have the following parts:

- A TitleView (Might subclass ToolbarView.)
    This is a view that only only display a title in a div. This might be 
    expanded later to add toolbar button functionality.

- A View controller:
    Is a backbone model which can contain; a titleView and a childView (The 
    child view is your own custom view.)

- A navigation controller.
    A navigation controller contains a list of view controllers and has a stack.
    You can push and pop views off the stack. The views are animated.


Todo:

Navigation Controller animation should be argument on `pop` or `push.` To make
the transitions flow together.

