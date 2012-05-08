var ChildView = Backbone.View.extend({
  render: function() {
    return this.el
  }
});



describe("View", function() {

  describe("Controller View", function() {
    it(" should return false on render() if a model and model.childView are not set.", function() {
      // test failure.
      var vcView = new jmbo.view._ControllerView();
      expect(vcView.render()).toEqual(false);
      expect(vcView.model).toBeUndefined();

      // create a childView, and view controller.
      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      vcView.model = vc;
      // render should return an div element
      expect($(vcView.render()).hasClass(vcView.className)).toEqual(true);
    });
  });
});




describe("Navigation", function() {
  

  describe("Controller View", function() {
    var navigationControllerView;

    beforeEach(function() {
      navigationControllerView = new jmbo.navigation.ControllerView
    });

    it ("should begin with an empty collection of ViewControllers", function() {
      expect(navigationControllerView.collection.length).toEqual(0);
    });

    it ("should be able to add a view controller.", function() {
      var cv1 = new ChildView;
      var vc1 = new jmbo.view.Controller({childView: cv1});
      navigationControllerView.pushViewController(vc1);
      expect(navigationControllerView.collection.length).toEqual(1);

      var cv2 = new ChildView;
      var vc2 = new jmbo.view.Controller({childView: cv2});
      navigationControllerView.pushViewController(vc2);
      expect(navigationControllerView.collection.length).toEqual(2);
    });

    it ("should be able to remove a view controller.", function() {

      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      navigationControllerView.pushViewController(vc);
      expect(navigationControllerView.collection.length).toEqual(1);

      vc_popped = navigationControllerView.popViewController();
      expect(vc_popped).toBe(vc);
      expect(navigationControllerView.collection.length).toEqual(0);


    });

    it ("shouldn't return null if trying to pop from empty collection.", function() {
      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      navigationControllerView.pushViewController(vc);
      expect(navigationControllerView.collection.length).toEqual(1);

      vc_popped = navigationControllerView.popViewController();
      expect(vc_popped).toBe(vc);
      expect(navigationControllerView.collection.length).toEqual(0);

      vc_popped = navigationControllerView.popViewController();
      expect(vc_popped).toEqual(null);
    });

  });
});

// describe("Player", function() {
//   var player;
//   var song;

//   beforeEach(function() {
//     player = new Player();
//     song = new Song();
//   });

//   it("should be able to play a Song", function() {
//     player.play(song);
//     expect(player.currentlyPlayingSong).toEqual(song);

//     //demonstrates use of custom matcher
//     expect(player).toBePlaying(song);
//   });

//   describe("when song has been paused", function() {
//     beforeEach(function() {
//       player.play(song);
//       player.pause();
//     });

//     it("should indicate that the song is currently paused", function() {
//       expect(player.isPlaying).toBeFalsy();

//       // demonstrates use of 'not' with a custom matcher
//       expect(player).not.toBePlaying(song);
//     });

//     it("should be possible to resume", function() {
//       player.resume();
//       expect(player.isPlaying).toBeTruthy();
//       expect(player.currentlyPlayingSong).toEqual(song);
//     });
//   });

//   // demonstrates use of spies to intercept and test method calls
//   it("tells the current song if the user has made it a favorite", function() {
//     spyOn(song, 'persistFavoriteStatus');

//     player.play(song);
//     player.makeFavorite();

//     expect(song.persistFavoriteStatus).toHaveBeenCalledWith(true);
//   });

//   //demonstrates use of expected exceptions
//   describe("#resume", function() {
//     it("should throw an exception if song is already playing", function() {
//       player.play(song);

//       expect(function() {
//         player.resume();
//       }).toThrow("song is already playing");
//     });
//   });
// });