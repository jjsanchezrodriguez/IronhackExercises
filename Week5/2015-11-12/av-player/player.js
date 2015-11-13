'use strict'

$(document).ready(function() {

    var vidCounter = {
        total: null,
        videos: {},
    }

    var localVideos = window.localStorage.getItem('videos');
    var localTime = window.localStorage.getItem('totalTime');

    function reloadVideos() {
        if (localVideos) {
            var videos = JSON.parse(localVideos);
            vidCounter.videos = videos;

            for(var url in vidCounter.videos) {
                addVideo(url);
                var video = $("video[src='" + url + "']");
                video.prop('currentTime', vidCounter.videos[url].time)
                if (vidCounter.videos[url].playing){
                    video.get(0).play();
                } else {
                    video.get(0).pause();
                }
            }
        }

        if (localTime){
            vidCounter.total = parseFloat(localTime);
            $('#total-time').text(vidCounter.total);
        } else {
            vidCounter.total = 0.00;
            saveToLocalStorage();
        }
    }

    function addVideo(url) {
        var vidDiv = $('<div>').addClass('videobox');
        var vid = $('<video controls>').attr('src', url);
        var counter = $('<div>').addClass('counter');
        $(vidDiv).append(vid, counter);
        $('#vidbox').append(vidDiv);
        bindControls();
    }

    function saveToLocalStorage(){
        window.localStorage.setItem('videos', JSON.stringify(vidCounter.videos));
        window.localStorage.setItem('totalTime', JSON.stringify(vidCounter.total));
    }

    $('input[type=submit]').click(function(event){
        event.preventDefault();
        var videoURL = $('input[type=text]').val();
        vidCounter.videos[videoURL] = {}
        vidCounter.videos[videoURL].time = 0.00;
        saveToLocalStorage();
        addVideo(videoURL);
        bindControls();

    });

    reloadVideos();
    bindControls();

    function bindControls() {

        $('button#reset-time').click(function(event){
            vidCounter.total = 0.00;
            for (var vid in vidCounter.videos) {
                vidCounter.videos[vid].time = 0.00;
            }
            saveToLocalStorage();
        })
        
        $('video').on('timeupdate',function(event){
            var currentVideo = vidCounter.videos[$(this).prop('src')];
            $(this).parent().find('.counter').text($(this).prop('currentTime'));
            currentVideo.playing = true;
            currentVideo.time = $(this).prop('currentTime');
            saveToLocalStorage();
        });

        $('video').on('pause', function(){
            var currentVideo = vidCounter.videos[$(this).prop('src')];
            currentVideo.playing = false;
            currentVideo.time = $(this).prop('currentTime');
            var count = 0;
            for (var vid in vidCounter.videos) {
                count += vidCounter.videos[vid].time
            }
            vidCounter.total = count;
            
            $('#total-time').text(vidCounter.total)
            saveToLocalStorage();
        })

    }


});
