// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.ctrl-tournaments.actn-index').ready(tournamentsIndex)

$('[data-hook~=tourney-add]').on('click', showTournamentForm)
$('section.js-tourney-section').on('click','button.delete-tourney', deleteTournament)
$('[data-hook~=tourney-form]').on('submit', createTournament)
