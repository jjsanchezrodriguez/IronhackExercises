function deleteTournament() {
  var tournamentId = $(this).attr('data')

  var request = $.ajax({
      url: '/api/tournaments.json',
      type: 'DELETE',
      data: { id: parseInt(tournamentId)},
    });

  tournamentsIndex()
}
