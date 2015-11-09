// Write your Pizza Builder JavaScript in this file.

var Pizza = function(price){
    this.total_price = price 
}

$(document).on('ready', function() {

    pizza = new Pizza(21);

    function updatePriceTag() {
        $('strong').text(pizza.total_price + ' $') 
    }

    function updatePrice(e) {
        if ($(e.target).hasClass('active')) {
            if ($(e.target).hasClass('btn-pepperonni')) {
                    pizza.total_price -= 1;
                    $('#item-pepperonni').hide()
            } else if ($(e.target).hasClass('btn-mushrooms')) {
                    pizza.total_price -= 1;
                    $('#item-mushroom').hide()
            } else if ($(e.target).hasClass('btn-green-peppers')) {
                    pizza.total_price -= 1;
                    $('#item-green-pepper').hide()
            } else if ($(e.target).hasClass('btn-sauce')) {
                    pizza.total_price -= 3;
                    $('#item-sauce').hide()
            } else {
                    pizza.total_price -= 5;
                    $('#item-glutten-free').hide()
            }
        } else {
            if ($(e.target).hasClass('btn-pepperonni')) {
                    $('#item-pepperonni').show()
                    pizza.total_price += 1;
            } else if ($(e.target).hasClass('btn-mushrooms')) {
                    pizza.total_price += 1;
                    $('#item-mushroom').show()
            } else if ($(e.target).hasClass('btn-green-peppers')) {
                    pizza.total_price += 1;
                    $('#item-green-pepper').show()
            } else if ($(e.target).hasClass('btn-sauce')) {
                    pizza.total_price += 3;
                    $('#item-sauce').show()
            } else {
                    pizza.total_price += 5;
                    $('#item-glutten-free').show()
            }
        }
    }

    updatePriceTag();

    // default behaviour
    $('#pizza section.crust section.cheese').hide();
    $('.btn-crust').removeClass('active');
    $('#item-glutten-free').hide();

    $('.btn-green-peppers').on('click', function() {
        updatePrice(event);
        updatePriceTag();
        $(this).toggleClass('active');
        $('#pizza section.green-pepper').toggle();
    })

    $('.btn-pepperonni').on('click', function() {
        updatePrice(event);
        updatePriceTag();
        $(this).toggleClass('active');
        $('#pizza section.pep').toggle();
    })

    $('.btn-mushrooms').on('click', function() {
        updatePrice(event);
        updatePriceTag();
        $(this).toggleClass('active');
        $('#pizza section.mushroom').toggle()
    })

    $('.btn-crust').on('click', function() {
        updatePrice(event);
        updatePriceTag();
        $(this).toggleClass('active');
        $('#pizza section.crust section.cheese').toggle()
    })

    $('.btn-sauce').on('click', function() {
        updatePrice(event);
        updatePriceTag();
        $(this).toggleClass('active');
        $('#pizza section.crust section.sauce').toggle()
    })
})

