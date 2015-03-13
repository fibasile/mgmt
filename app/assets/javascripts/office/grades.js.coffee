jQuery ->
  $.fn.peity.defaults.pie = {
    delimiter: null,
    fill: ["#66CC99", "red"],
    height: null,
    radius: 5,
    width: null
  }
  $(".pie").peity("pie");

  $('form.grade-form input, form.grade-form textarea').change ->
    $(this).parents('form').submit()

  $('select#order').change ->
    $('#search').val('')
    options = {
      valueNames: [ 'name' ]
    }
    gradeList = new List('grades', options)
