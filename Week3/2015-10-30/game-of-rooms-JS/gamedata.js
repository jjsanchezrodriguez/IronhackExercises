var gamedata = [
    { 
    'name': 'Dark room',
    'description': 'You are in a dark room. There is a door to the north.' ,
    'exits': { 'n': 'Forest' },
    'items': []
    },
    { 
    'name': 'Forest',
    'description': 'You are in the forest. There is a lot of light. There \nis a bear sleeping and you see a path to the east.' ,
    'exits': { 's': 'Dark room', 'e': 'Forest path' },
    'items': []
    },
    { 
    'name': 'Forest path',
    'description': 'You are on a beaten forest path that continues to east.' ,
    'exits': { 'w': 'Forest', 'e': 'Mountain'},
    'items': ['knife', 'fork']
    },
    { 
    'name': 'Mountain',
    'description': 'You get to a huge mountain. If you keep going north you can \nclimb it.' ,
    'exits': { 'w': 'Forest path', 'n': 'Death'},
    'items': []
    },
    { 
    'name': 'Death',
    'description': 'You die!' ,
    'exits': { },
    'items': []
    },
]


module.exports = gamedata;
