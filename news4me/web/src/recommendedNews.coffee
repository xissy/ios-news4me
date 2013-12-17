userId = null
accessToken = null
shownArticleIds = []


connectWebViewJavascriptBridge (currentBridge) ->
  bridge = currentBridge

  bridge.init (message, responseCallback) ->
    if message is 'loadMore'
      apiUrl = "#{baseUrl}/news/facebook/#{userId}?accessToken=#{accessToken}"
      loadArticles apiUrl, bridge
    
    if message is 'refresh'
      while articles.length > 0
        articles.pop()
      apiUrl = "#{baseUrl}/news/facebook/#{userId}?accessToken=#{accessToken}"
      loadArticles apiUrl, bridge

  bridge.send 'init', (result) ->
    userId = result.userId
    accessToken = result.accessToken
    apiUrl = "#{baseUrl}/news/facebook/#{userId}?accessToken=#{accessToken}"
    loadArticles apiUrl, bridge


notifyShownArticle = (articleId, callback) ->
  apiUrl = "#{baseUrl}/articles/#{articleId}/show/from/facebook/#{userId}"
  $.get apiUrl, (data) ->
    callback null, data  if callback?


window.onscroll = (e) ->
  bodyTag = $('body')
  articleIdTags = $('.article .id')

  articleIdTags.each (index, item) ->
    articleIdTag = articleIdTags.eq(index)
    articleId = articleIdTag.text()
    articleIdTagTop = articleIdTag.parent().offset().top
    
    return  if articleId in shownArticleIds

    if articleIdTagTop < bodyTag.scrollTop()
      shownArticleIds.push articleId
      notifyShownArticle articleId
