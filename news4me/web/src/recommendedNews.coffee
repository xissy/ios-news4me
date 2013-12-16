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

connectWebViewJavascriptBridge (bridge) ->
  bridge.init (message, responseCallback) ->
    alert "Received message: #{JSON.stringify message}"
    responseCallback 'Right back atcha from webview'  if responseCallback

  bridge.send 'getApiUrl', (recommendedNewsApiUrl) ->
    $.getJSON recommendedNewsApiUrl, (articles) ->
      for article in articles
        article.onTap = (e) ->
          alert e
          
        article.pubDate = new Date article.pubDate
        d = article.pubDate
        article.pubDateString = article.pubDateString = "#{d.getFullYear()}-#{d.getMonth()+1}-#{d.getDate()} #{d.getHours()}:#{d.getMinutes()}"

        article.hasImage = false
        if article.imageUrls?[0]?
          article.imageUrl = article.imageUrls[0]
          article.hasImage = true

        article.relatedKeywords = article.words.join ', '

      rivets.bind document.getElementById('articles'),
        articles: articles
      bridge.send 'onArticelsLoaded'


$(document).on 'ajaxSuccess', (xhr, options, data) ->
  # alert 'ajaxSuccess'

$(document).on 'ajaxError', (xhr, options, error) ->
  alert 'ajaxError'
