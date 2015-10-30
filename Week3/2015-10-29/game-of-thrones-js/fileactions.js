function fileActions(err, file){ 
    if (err) {
        throw err;
    }
    var episodes = JSON.parse(file);
    episodes = sortEpisodes(filterEpisodes(filterByQuery(episodes, "Jon")));
    episodePrinter(episodes);
}

function episodeStars(rating) {
    return Array(Math.round(rating)).join("*");
}

function sortEpisodes(episodes) {
    return episodes.sort(function(prev, current) {
        return prev['episode_number'] - current['episode_number'];
    })
}

function episodePrinter(episodes) {
    episodes.forEach(function(episode) {
        console.log("Title: " + episode['title'] + " Episode: " + episode['episode_number']);
        console.log("Title: " + episode['description']);
        console.log("Title: " + episode['rating'] + " " + episodeStars(episode['rating']));
        console.log("\n");
    });
}

function filterEpisodes(episodes) {
    return episodes.filter(function(episode) {
        return episode['rating'] > 8.5;
    }) 
}

function filterByQuery(episodes, query) {
    return episodes.filter(function(episode) {
        if (episode['description'].indexOf(query) != -1) {
            return episode;
        }
        })
    }

module.exports = fileActions;
