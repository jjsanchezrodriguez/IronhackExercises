def get_gamedata
  [
    { 'name' => "hallway",
      'description' =>
"""You are standing in a dark hallway with
locked door behind you.
You have no idea how you got here. The last thing you remember is a figure
of tall, slender man.""", 
       'description_visited' => 
"""This is the hallway you started on.""",
        'items' => { 'letter' => "There is a letter laying on the floor." },
       'exits' => { 'n' => 'main hall'} },

    { 'name' => "main hall",
      'description' => 
"""The hallway opens into a big central hall. It has three other doors.
You feel a chill as you enter towards the center. You think you heard a creak
in an other room but maybe your mind is playing tricks on you.""", 
       'description_visited' => 
"""The main hall with three doors leading to living room, kitchen and hallway and
dining room.""",
       'items' => {}, 
       'exits' => { 'n' => 'dining room', 'w' => 'living room', 'e' => 'kitchen', 's' => 'hallway'} },

    { 'name' => "living room",
      'description' => 
"""You enter a surprisingly small living room. There is a sofa and a fireplace.
No TV, just very old transistor radio. You feel like you know this place.
There is a closed door to the north.""",
       'description_visited' => 
"""The living room with transistor radio.""",
       'items' => {}, 
       'exits' => { 'n' => 'office', 'e' => 'main hall'} },
    
    { 'name' => "office",
      'description' => 
"""Large oak office table is the dominant element in the room. Next to it
you see a whiskey cabinet. The table has a picture frame on it.
The photo was taken out from the frame. You see no other door here but
the one you came from.""", 
       'description_visited' => 
"""The office with large oak tree.""",
      'items' => { 'whiskey' => 'You see a whiskey bottle winking at you.' }, 
       'exits' => { 's' => 'living room'} },

    { 'name' => "kitchen",
      'description' => 
"""The stench almost makes you vomit. Piles and piles of dirty dishes are carefully
balancing in the sink. The refrigerator has rotting food in it. Kitchen has a small
window overlooking the garden lush with life.""", 
        'description_visited' =>
"""The messy kitchen, please let's not come back it stinks here.""",
      'items' => { 'knife' => "You notice a knife in the room." },
       'exits' => { 'w' => 'main hall'} },

    { 'name' => "dining room",
      'description' => 
"""The dining room has to be the biggest room in the house. It has a long table 
with empty dishes set up on it. The lights don't work here but table has candles
on it that are lit. It's as if someone was expecting you. You see no other exits
but the one you came from.""", 
        'description_visited' =>
"""The candle-lit dining room with long table.""",
      'items' => { 'plate' => "A pink plate is here." },
       'exits' => { 's' => 'main hall'} },

    { 'name' => "death",
      'description' => 
"""
As you start to read the letter you begin to notice maniacal laughter in your head.
It is too late to realize that you are actually reading about the slender man.
Oh my god... You feel tension in your head.

BOOm. Your head explodes!

""", 
        'description_visited' =>
"""The story of how you died.""",
      'items' => {  },
       'exits' => { 'n' => 'another dimension' }}
  ]
end
