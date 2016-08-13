App.spreadsheet =
  active_users: {}

  set_current_user: (user) ->
    @current_user = user

  new_user: (user) ->
    @active_users[user.id] = user
    @number_users()
    @render_activer_users()
    @render_selected_cells()

  number_users: () ->
    num = 0
    for id, user of @active_users
      if id != @current_user.id
        num += 1
        user.num = num

  remove_user: (user) ->
    delete @active_users[user.id]
    @render_activer_users()

  render_activer_users: () ->
    $('#active_users_list').html(
      ("<li class=\"user-#{user.num}\">#{user.id}</li>" for id,user of @active_users).join("")
    )

  render_selected_cells: () ->
    for cells in @selected_cells
      cell = @hot.getCell(cells.r, cells.c)
      if cell.classList.contains('current')
        cell.classList = 'current'
      else
        cell.classList = ''

    @selected_cells = []
    for id, user of @active_users
      if id != @current_user.id && (cells = user.selected_cells)
        @selected_cells.push(cells)
        cell = @hot.getCell(cells.r, cells.c)
        cell.classList.add('user-' + user.num)

  setup: () ->
    @selected_cells = []
    container = document.getElementById('spreadsheet')
    @hot = new Handsontable(container,
      minSpareCols: 1
      minSpareRows: 1
      rowHeaders: true
      colHeaders: true
      contextMenu: true
      afterSelection: () => @select_cells(arguments)
      afterDeselect: () => @deselect_cells()
    )

  select_cells: (cells) -> 
    App.active_users.select_cells(r: cells[0], c: cells[1], r2: cells[2], c2: cells[3])

  deselect_cells: () -> 
    App.active_users.select_cells(null)

$ -> App.spreadsheet.setup()
