// Init code

PokemonApp = {
};

PokemonApp.init = function(){
    console.log('Pokemon App initialized!');
}

$(document).ready(function(){

    PokemonApp.init();

    $('.js-show-pokemon').click(function() {
        var uri = $(this).data('pokemon-uri');
        var pokemon = new PokemonApp.Pokemon(uri);
        pokemon.render();


        $('button#evolution-button').click(function() {
            pokemon.renderEvolutions();

            //$('.modal').modal('show').delay(2000);
        });

    });



})
