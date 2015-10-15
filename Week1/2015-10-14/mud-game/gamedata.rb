def get_gamedata
  [
    { name: "hallway",
      description: 
"""You are standing in a dark hallway with
locked door behind you.""", 
        description_visited:
"""This is the hallway you started on.""",
        items: { letter: "There is a letter laying on the floor." },
       exits: {n: 'stair way'} },

    { name: "stair way",
      description: 
"""This is entrance with stairs.""", 
        description_visited:
"""It's the stairway again.""",
       items: {}, 
       exits: {w: 'living room', e: 'kitchen', s: 'hallway'} },

    { name: "living room",
      description: 
"""This is a living room. It smells weird here.""",
        description_visited:
"""You've been here.""",
       items: {}, 
       exits: {n: 'office', e: 'stair way'} },
    
    { name: "office",
      description: 
"""You are in office.""", 
        description_visited:
"""Office still looks the same.""",
       items: {}, 
       exits: {s: 'living room'} },

    { name: "kitchen",
      description: 
"""Kitchen overflowing with dirty dishes.""", 
        description_visited:
"""It's still messy here.""",
      items: { knife: "You see a knife laying on the countertop." },
       exits: {w: 'stair way'} },
  ]
end
