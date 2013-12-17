userId = null
articleOffset = 0


connectWebViewJavascriptBridge (currentBridge) ->
  bridge = currentBridge

  bridge.init (message, responseCallback) ->
    if message is 'loadMore'
      apiUrl = "#{baseUrl}/news/facebook/#{userId}/read/#{articleOffset}"
      articleOffset += 20
      loadArticles apiUrl, bridge

    if message is 'refresh'
      while articles.length > 0
        articles.pop()
      articleOffset = 0
      apiUrl = "#{baseUrl}/news/facebook/#{userId}/read/#{articleOffset}"
      loadArticles apiUrl, bridge

  bridge.send 'init', (result) ->
    userId = result.userId
    apiUrl = "#{baseUrl}/news/facebook/#{userId}/read/#{articleOffset}"
    articleOffset += 20
    loadArticles apiUrl, bridge
