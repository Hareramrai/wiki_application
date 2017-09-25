App.articles = App.cable.subscriptions.create "ArticlesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log 'connected'
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log data
    $("div.article-previews").prepend(data['article']);

