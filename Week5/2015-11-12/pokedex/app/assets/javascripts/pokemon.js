PokemonApp.Pokemon = function(pokemonUri) {
    this.id = PokemonApp.idFromUri(pokemonUri);
    this.evolutions = [];
};

PokemonApp.Pokemon.prototype.render = function() {
    var self = this;
    var details = $('.modal-body dl');
    details.empty();
    $('div.evolutions').empty();

    $.ajax({
        url: '/api/pokemon/' + this.id,
        success: function(info) {
            self.info = info;
            //console.log(self.info);
            $('.modal-title').text(self.name);
            $('h3.modal-title span').text(self.info.name);
            $('h3.modal-title small').text(self.info.pkdx_id);

            function addProperty(property, value) {
                details.append($("<dt>").text(property));
                details.append($("<dd>").text(value));
            }


            addProperty("Hitpoints", self.info.hp);
            addProperty("Height", self.info.height);
            addProperty("Weight", self.info.weight);
            addProperty("Attack", self.info.attack);
            addProperty("Defense", self.info.defense);

            self.info.types.forEach(function(type) {
                addProperty("Type", type.name);
            });

            $('.modal.fade').modal();

            function addDescription(descInfo){
                $('.description').empty();
                var desc = $('<p>').text(descInfo.description);
                $('.description').append(desc);
            }

            // description
            var descUrl = self.info.descriptions[self.info.descriptions.length - 1];
            PokemonApp.simpleAjaxCall(descUrl.resource_uri, addDescription);
            
            // image
            var avatar = $('.modal-body .avatar');
            avatar.empty();
            PokemonApp.simpleAjaxCall('http://pokeapi.co/api/v1/sprite/' + self.id, getImage)

            function getImage(imgInfo){
                self.imgInfo = imgInfo;
                var imageUrl = PokemonApp.addImage(imgInfo);
                var image = $('<img>').addClass('pokemon-avatar').attr('src', imageUrl);
                avatar.append(image);
            }


        }
    });
    


};

PokemonApp.idFromUri = function(uri) {
    var parts = uri.split('/');
    return parts[parts.length - 2];
};

PokemonApp.addImage = function(imgInfo){
    return 'http://pokeapi.co' + imgInfo.image;
}

PokemonApp.simpleAjaxCall = function(url, success) {
    $.ajax({
        url: url,
        success: success
    })
}

PokemonApp.Pokemon.prototype.renderEvolutions = function() {
    var self = this;

    function fetchEvolutions() {
        console.log('***** ', self.info)
        self.info.evolutions.forEach(function(evolution){
            $.ajax({
                url: evolution.resource_uri,
                success: function(evolution) {
                    self.evolutions.push(evolution);
                    if (self.evolutions.length === self.info.evolutions.length) {
                        pushToDiv();
                    }
                }
            })
        })

    }

    function pushToDiv() {
        self.evolutions.forEach(function(evolution) {
            console.log(evolution);
            var evolutionItem = $('<a>').text(evolution.name).attr('href', evolution.resource_uri);
            $('div.evolutions').append(evolutionItem);
            var imageUrl = evolution.sprites[0].resource_uri;
            $.ajax({
                url: imageUrl,
                success: function(evolution) {
                    var evolutionImage = $('<img>').attr('src', 'http://pokeapi.co' + evolution.image);
                    $('div.evolutions').append(evolutionImage);
                }
            })
        });
    }

    fetchEvolutions();

}

