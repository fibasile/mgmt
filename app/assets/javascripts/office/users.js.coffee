jQuery ->
  $('#search').val('')
  options = {
    valueNames: [ 'name', 'country', 'email', 'programs' ],
    page: 50,
    plugins: [ ListPagination({innerWindow: 100}) ]
  }

  userList = new List('users', options)
