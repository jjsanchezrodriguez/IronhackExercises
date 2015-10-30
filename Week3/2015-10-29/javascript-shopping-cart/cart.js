var Item = require('./item')

var ShoppingCart = function() {
    this.items = [];
    this.quantities = {};
};

ShoppingCart.prototype.addItem = function(item) {
    this.items.push(item);
};

ShoppingCart.prototype.setQuantities = function() {
    var quantities = this.quantities;
    this.items.forEach(function(item) {
        if (item.name in quantities) {
            quantities[item.name]++;
        } else {
            quantities[item.name] = 1;
        }
    });
}

ShoppingCart.prototype.volumeDiscount = function() {
    return this.items.length > 4 ? 0.9 : 1.0;
}

ShoppingCart.prototype.appleDiscount = function() {
    if ('apple' in this.quantities) {
        var freeApples = Math.floor(this.quantities['apple']/2);
        for (var i = freeApples; i > 0; i--) {
            this.addItem(new Item('apple', 0));
        };
    }
}

ShoppingCart.prototype.orangeDiscount = function() {
    if ('orange' in this.quantities && this.quantities['orange'] > 5) {
        for (var i = 5; i > 0; i--) {
            this.addItem(new Item('orange', 2.5));
        }
    }
}

ShoppingCart.prototype.total = function() {
    subtotal = this.items.map(function(item) { return item.price })
    .reduce(function(prev, current) { return prev + current });

    this.setQuantities();
    this.appleDiscount();
    this.orangeDiscount();

    return subtotal * this.volumeDiscount();
}

var shoppingCart = new ShoppingCart;

shoppingCart.addItem(new Item('apple', 10));
shoppingCart.addItem(new Item('apple', 10));
shoppingCart.addItem(new Item('apple', 10));
shoppingCart.addItem(new Item('apple', 10));
shoppingCart.addItem(new Item('orange', 5));
shoppingCart.addItem(new Item('orange', 5));
shoppingCart.addItem(new Item('orange', 5));
shoppingCart.addItem(new Item('orange', 5));
shoppingCart.addItem(new Item('orange', 5));
shoppingCart.addItem(new Item('orange', 5));
shoppingCart.addItem(new Item('orange', 5));
shoppingCart.addItem(new Item('grapes', 15));
shoppingCart.addItem(new Item('banana', 20));
shoppingCart.addItem(new Item('watermelon', 50));
console.log(shoppingCart.total());
console.log(shoppingCart.items);
