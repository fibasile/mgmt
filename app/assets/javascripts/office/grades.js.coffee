jQuery ->
  $('form.grade-form input, form.grade-form textarea').change ->
    $(this).parents('form').submit()

  $('select#order').change ->
    $('#search').val('')
    options = {
      valueNames: [ 'name' ]
    }
    gradeList = new List('grades', options)
