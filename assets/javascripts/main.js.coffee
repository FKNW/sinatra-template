String.prototype.htmlEscape = () ->
    span = document.createElement('span')
    txt =  document.createTextNode('')
    span.appendChild txt
    txt.data = this
    return span.innerHTML
    
$ ->
  ($ 'input#start_btn').click omikuji_start

omikuji_start = () ->
  name = ($ 'input#name_text').val()
  $.getJSON "#{omikuji_api}?name=#{name}", (res) ->
    console.log res
    result = res.result.htmlEscape()
    time = res.time.htmlEscape()
    li = ($ '<li>').append("#{result} - #{time}")
    ($ 'ul#results').prepend li
