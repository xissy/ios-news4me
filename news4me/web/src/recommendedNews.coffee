bridge = null
articles = []
recommendedNewsApiUrl = null

rivets.bind document.getElementById('articles'),
  articles: articles


connectWebViewJavascriptBridge = (callback) ->
  if window.WebViewJavascriptBridge
    callback WebViewJavascriptBridge
  else
    document.addEventListener 'WebViewJavascriptBridgeReady'
    ,
      ->
        callback WebViewJavascriptBridge
    ,
      false

connectWebViewJavascriptBridge (currentBridge) ->
  bridge = currentBridge

  bridge.init (message, responseCallback) ->
    if message is 'loadMore'
      loadArticles()

  bridge.send 'getApiUrl', (apiUrl) ->
    recommendedNewsApiUrl = apiUrl
    loadArticles()


$(document).on 'ajaxSuccess', (xhr, options, data) ->
  # alert 'ajaxSuccess'

$(document).on 'ajaxError', (xhr, options, error) ->
  alert 'ajaxError'


loadArticles = ->
  $.getJSON recommendedNewsApiUrl, (currentArticles) ->
    for article in currentArticles
      do (article) ->
        article.onTap = (e) ->
          bridge.send
            message: 'onTapArticle'
            articleUrl: article.articleUrl

      article.pubDate = new Date article.pubDate
      d = article.pubDate
      article.pubDateString = article.pubDateString = "#{d.getFullYear()}-#{d.getMonth()+1}-#{d.getDate()} #{d.getHours()}:#{d.getMinutes()}"

      article.hasImage = false
      if article.imageUrls?[0]?
        article.imageUrl = article.imageUrls[0]
        article.hasImage = true

      article.relatedKeywords = article.words.join ', '

      articles.push article

    bridge.send 'onArticelsLoaded'
