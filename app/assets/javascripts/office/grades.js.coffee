jQuery ->
  $.fn.peity.defaults.pie = {
    delimiter: null,
    fill: ["#66CC99", "red"],
    height: null,
    radius: 5,
    width: null
  }
  $(".pie").peity("pie");

  window.gradeList = new List('grades', valueNames: [ 'grade-name', 'grade-grade','grade-group','grade-comments' ])

  $(".best_in_place").best_in_place();
  $('.best_in_place').bind "ajax:success", ->
    window.gradeList = new List('grades', { valueNames: [ 'grade-name', 'grade-grade','grade-group','grade-comments' ] })
    setTimeout ->
      window.gradeList = new List('grades', { valueNames: [ 'grade-name', 'grade-grade','grade-group','grade-comments' ] })
    , 200
