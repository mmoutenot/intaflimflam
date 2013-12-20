// function loadVideos(){
//   $.ajax({
//     dataType: "json",
//     url: '/videos',
//     success: function(data){
//       $.each(data, function(index) {
//         console.log(data[index]);
//         $('#videos').append(
//           '<video id='+index+' autoplay="false"><source src="'+data[index].url+'"></source></video>'
//         );
//         $('video#'+index).get(0).pause();
//       });
//       var videos = $('video');
//       var numVideos = videos.size();
//       for (var i = numVideos-1; i >= 0; i--) {
//         if (i == 0){
//           $('video#'+i).bind('ended', { index: i }, function(event) {
//             $('video#'+i).id = '-1';
//             loadVideos();
//           });
//         } else {
//           $('video#'+i).bind('ended', { index: i }, function(event) {
//             var index = event.data.index;
//             $('video#'+index).remove();
//             $('video#'+(index-1)).get(0).play();
//           });
//         }
//       }
//       firstVideosHaveLoaded();
//     }
//   });
// }
//
// function firstVideosHaveLoaded(){
//   $('video').last().get(0).play();
// }
//
// $(window).load(function() {
//   loadVideos(firstVideosHaveLoaded);
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
