jQuery ->
  $.fn.peity.defaults.pie = {
    delimiter: null,
    fill: ["#66CC99", "red"],
    height: null,
    radius: 5,
    width: null
  }
  $(".pie").peity("pie");

  # $('form.grade-form input, form.grade-form textarea').change ->
  #   $(this).parents('form').submit()

  $(".best_in_place").best_in_place();

  # # $('select#order').change ->
  # # $('#search').val('')
  # options = {
  #   valueNames: [ 'name' ]
  # }
  # window.gradeList = new List('users', options)

  # $('th.sorter').click ->
  #   window.gradeList.sort($(this).data('sorter'))

  # window.gradeList.sort('group', {
  #   sortFunction: (a, b) -> [$(a.elm).find('.group').val(), $(b.elm).find('.group').val()].sort(naturalSort)
  # })
  # window.gradeList.sort('grade', {
  #   sortFunction: (a, b) -> [$(a.elm).find('.grade').val(), $(b.elm).find('.grade').val()].sort(naturalSort)
  # })
  # window.gradeList.sort('student', {
  #   sortFunction: (a, b) -> [$(a.elm).find('.student').val(), $(b.elm).find('.student').val()].sort(naturalSort)
  # })