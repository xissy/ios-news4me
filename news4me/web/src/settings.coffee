bridge = null

userId = null
profile =
  userId: null
  userName: null
  imageUrl: null
  logout: ->
    bridge.send 'logout'


rivets.bind document.getElementById('profile'),
  profile: profile


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

  bridge.send 'init', (result) ->
    profile.userId = result.userId
    profile.userName = result.userName
    profile.imageUrl = "http://graph.facebook.com/#{profile.userId}/picture?type=square"
