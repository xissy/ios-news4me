bridge = null
articles = []
userId = null
articleOffset = 0


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

  bridge.send 'init', (result) ->
    userId = result.userId
    loadArticles()


$(document).on 'ajaxSuccess', (xhr, options, data) ->
  # alert 'ajaxSuccess'

$(document).on 'ajaxError', (xhr, options, error) ->
  alert 'ajaxError'


loadArticles = ->
  apiUrl = "#{baseUrl}/news/facebook/#{userId}/read/#{articleOffset}"
  articleOffset += 20

  $.getJSON apiUrl, (currentArticles) ->
    for article in currentArticles
      do (article) ->
        article.onTap = (e) ->
          bridge.send
            message: 'onTapArticle'
            articleUrl: article.articleUrl
            articleId: article.id

      article.pubDate = new Date article.pubDate
      article.pubDateString = article.pubDateFromNowString

      article.hasImage = false
      article.hasImage = true  if article.imageUrl?

      article.relatedKeywords = article.keywords.join ', '

      isDuplicated = false
      for storedArticle in articles by -1
        if storedArticle.id is article.id
          isDuplicated = true
          break
      
      articles.push article  if not isDuplicated

    bridge.send 'onArticlesLoaded'
