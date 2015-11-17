function buildTourneyHtml(tournament) {

  function getTourneyPlayers(tourneyId) {
    $.ajax({
      url: '/api/players.json',
      type: 'GET',
      dataType: 'json',
      success: function(response) {
        var select = $('select[data="' + tourneyId + '"]')
        response.forEach(function(player) {
          $(select).append('<option>' + player.name + '</option>')
        })
      }
    })
  }

  function getAllPlayers(tourneyId) {
    $.ajax({
      url: '/api/players.json',
      type: 'POST',
      dataType: 'json',
      data: {
        "tournament": {
          "id": tourneyId
        }
      },
      success: function(response) {
        var div = $('div.tourney-players[data="' + tourneyId + '"]')
        response.forEach(function(player) {
          $(div).append('<div>' + player.name + '</div>')
        })
      }
    })
  }

  return '\
    <li>\
      <a href="/tournaments/' + tournament.id + '">' + tournament.name + '</a>' +

    '<div class="tourney-players" data="' + tournament.id + '">' + getAllPlayers(tournament.id) +
    '</div>' +
    '<div>' +
    '<form class="select-player">' +
    '<select data="' + tournament.id + '">' + getTourneyPlayers(tournament.id) + '</select>' +
    '</div>' +
    '<button class="add-player btn btn-primary" data=' + tournament.id + '>Add Player</button>' +
    '</div>' +
    '</form>' +
    '<button class="delete-tourney btn btn-primary" data=' + tournament.id + '>Delete</button>' +
    '</div>' +
    '</li>\
  '
}
