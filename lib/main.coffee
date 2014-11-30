meteorHashTable = (list) ->
  a = []
  _.each list, (val, key) ->
    a.push
      key:key
      val:val
  return a

LangList =
  "ru": "RUS"
  "en": "ENG"

getCookie = (name) ->
  fullCookie = document.cookie
  startIndex = fullCookie.indexOf(name + "=")
  return null  if startIndex is -1 # named cookie not found
  startIndex = fullCookie.indexOf("=", startIndex) + 1
  endIndex = fullCookie.indexOf(";", startIndex)
  endIndex = fullCookie.length  if endIndex is -1
  unescape fullCookie.substring(startIndex, endIndex)

Meteor.startup ->

  Template.lang.helpers
    items: meteorHashTable(LangList)

  Template.lang.events
    "click a.lang": (event) ->
      event.preventDefault()
      lang = event.currentTarget.id
      document.cookie = "lang=" + lang + ";expires=Sat, 01 Jan 2050 00:00:00 GMT"
      T9n.language = lang
      window.location.reload()

  lang = getCookie("lang")
  unless lang
    lang = window.navigator.language || window.navigator.userLanguage
  if lang && _.has(LangList, lang)
    T9n.language = lang
