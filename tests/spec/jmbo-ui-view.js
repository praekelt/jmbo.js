describe("ui.view", function() {

  describe("ControllerView", function() {

    it("Should be cacheable", function() {

        var view = $('<div><div class="test_cache">this is a test.</div></div>');
        var controller = new jmbo.ui.view.ControllerView({
            view: view,
            cache: true
        });

        // should be null to begin with
        expect(controller.config.get('_cachedView')).toBe(null);
        controller.render()
        var c = $(controller.config.get('_cachedView'));
        expect(c.find('.test_cache').length).toEqual(1)

        controller.render()
    });


  });
});