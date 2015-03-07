jQuery ->
  $('#search').val('')
  options = {
    valueNames: [ 'name', 'country', 'email' ],
    page: 20,
    plugins: [ ListPagination({innerWindow: 100}) ]
  }

  userList = new List('users', options)
