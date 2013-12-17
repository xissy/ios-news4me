baseUrl = 'http://news.recom.io/api/v1'

bridge = null
articles = []


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


rivets.bind document.getElementById('articles'),
  articles: articles

rivets.formatters.articleId = (value) ->
  "article#{value}"


$(document).on 'ajaxSuccess', (xhr, options, data) ->
  # alert 'ajaxSuccess'

$(document).on 'ajaxError', (xhr, options, error) ->
  bridge.send 'ajaxError'
  alert '네트워크 연결에 실패했습니다. 다시 시도해 주세요.'


loadArticles = (apiUrl, bridge, callback) ->
  $.getJSON apiUrl, (currentArticles) ->
    for article in currentArticles
      do (article) ->
        articleId = article.id

        article.onTap = (e) ->
          bridge.send
            message: 'onTapArticle'
            articleUrl: article.articleUrl
            articleId: article.id
        
        article.onTapStarOn = (e) ->
          article.isStarred = not article.isStarred
          article.isNotStarred = not article.isNotStarred
          apiUrl = "#{baseUrl}/articles/#{articleId}/star/from/facebook/#{userId}"
          $.get apiUrl, (data) ->
            callback null, data  if callback?
        
        article.onTapStarOff = (e) ->
          article.isStarred = not article.isStarred
          article.isNotStarred = not article.isNotStarred
          apiUrl = "#{baseUrl}/articles/#{articleId}/star/delete/from/facebook/#{userId}"
          $.get apiUrl, (data) ->
            callback null, data  if callback?
        
        article.onTapDelete = (e) ->
          $("#article#{article.id}").hide()
          apiUrl = "#{baseUrl}/articles/#{articleId}/delete/from/facebook/#{userId}"
          $.get apiUrl, (data) ->
            callback null, data  if callback?

      article.isStarred = false  if not article.isStarred?
      article.isNotStarred = not article.isStarred

      article.pubDate = new Date article.pubDate
      d = article.pubDate
      article.pubDateString = "#{d.getFullYear()}년 #{d.getMonth()+1}월 #{d.getDate()}일 #{d.getHours()}시 #{d.getMinutes()}분"

      article.hasImage = false
      if article.imageUrls?[0]?
        article.imageUrl = article.imageUrls[0]
        article.hasImage = true

      if article.words?
        article.relatedKeywords = article.words.join ', '
      else if article.keywords?
        article.relatedKeywords = article.keywords.join ', '

      isDuplicated = false
      for storedArticle in articles by -1
        if storedArticle.id is article.id
          isDuplicated = true
          break
      
      articles.push article  if not isDuplicated

    bridge.send 'onArticlesLoaded'

    callback null  if callback?
