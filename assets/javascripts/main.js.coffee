String.prototype.htmlEscape = () ->
    span = document.createElement('span')
    txt =  document.createTextNode('')
    span.appendChild txt
    txt.data = this
    return span.innerHTML
    
$ ->
  ($ 'input#start_btn').click omikuji_start

omikuji_start = () ->
  $.getJSON omikuji_api, (res) ->
    console.log res
    result = res.result.htmlEscape()
    time = res.time.htmlEscape()
    li = ($ '<li>').append("#{result} - #{time}")
    ($ 'ul#results').prepend li
