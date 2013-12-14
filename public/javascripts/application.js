var Video = Backbone.Model.extend({
  defaults: function() {
    return { id: -1, url: '', playing: false};
  }
});

var VideoStore = Backbone.Collection.extend({
  model: Video,
    url: 'http://localhost:4567/videos'
});
var videos = new VideoStore;

var VideoView = Backbone.View.extend({

  tagName: "video",

  events: {
    "ended" : "ended"
  },

  initialize: function() {
  },

  ended: function(data) {
    this.model.destroy();
  },

  render: function() {
    this.$el.html(this.template(this.model.toJSON()));
    if (this.model.get('playing')){
      this.$el.play();
    }
    return this;
    // videos.each(function(video) {
    //   $('#videos').append(
    //     '<video id='+video.get('id')+'><source src="'+video.get('url')+'" type="video/mp4"></source></video>'
    //     )
    // });
  }

});

var view = new VideoView({el: $('#videos')});
videos.fetch({success: function(){view.render();}});

// $(window).load(function() {
//   var videos = $('video');
//   var numVideos = videos.size();
//   videos.last().get(0).play();
//   for (var i = numVideos-1; i > 0; i--) {
//     $('video#'+i).bind('ended', { index: i }, function(event) {
//       var index = event.data.index;
//       $('video#'+index).hide();
//       $('video#'+(index-1)).get(0).play();
//     });
//   }
// });

// $(document).ready(function() {
//   var intensity = 1.0;
//   $('body').noisy({
//     intensity: intensity,
//     size: 200,
//     opacity: 1,
//     monochrome: false,
//   });
//
//   setInterval(function(){
//     console.log(intensity);
//     intenity = 1.0 - 0.1;
//     $('body').noisy({
//       intensity: intensity,
//       size: 100,
//       opacity: 1,
//       monochrome: false,
//     });
//
//   }, 1000);
// });
