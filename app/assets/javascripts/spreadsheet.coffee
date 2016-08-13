App.spreadsheet =
  active_users: {}

  new_user: (user) ->
    @active_users[user.id] = user
    @render_activer_users()

  remove_user: (user) ->
    delete @active_users[user.id]
    @render_activer_users()

  render_activer_users: () ->
    $('#active_users_list').html(
      ("<li>#{user.id}</li>" for id,user of @active_users).join("")
    )

  setup: () ->
    container = document.getElementById('spreadsheet')
    @hot = new Handsontable(container,
      minSpareCols: 1
      minSpareRows: 1
      rowHeaders: true
      colHeaders: true
      contextMenu: true
    )

$ -> App.spreadsheet.setup()
