# get ptt post
streamy = require('streamy-data')

skip_post =
  food: ['M.1413030211.A.ADF', 'M.1128132666.A.0FD', 'M.1190944426.A.E6C', 'M.1037553999.A.D7B', 'M.1355673582.A.5F7']
  joke: ['M.1425288054.A.AD4','M.1274944143.A.07F']
  movie: ['M.1427123254.A.168','M.1427071910.A.6DC','M.1411349202.A.C57','M.1397887191.A.BD0']
  gossiping: ['M.1425139205.A.1D7','M.1422793398.A.ADA']
  hate: ['M.1422896473.A.C11','M.1418436610.A.D68','M.1413213116.A.B24']

boards = ['food', 'joke', 'movie', 'gossiping', 'hate']
boards = ['food', 'joke', 'movie', 'gossiping', 'hate']

post_url = (data)->
  return "https://www.ptt.cc/bbs/#{data.board}/#{data.post}.html"

post_text = (data) ->
  return "#{data.board} / #{data.title} by #{data.author}"

module.exports = (robot) ->

  robot.respond /ptt ([a-z]+)? ?([0-9]+)?/i, (msg) ->
    board = msg.match[1]
    limit = msg.match[2] || 1
    streamy.ptt.board(board, limit: limit).pipe(streamy.ptt.post()).on('data', (data) ->
      return if data.post in skip_post[board]
      msg.send post_text(data)
      msg.send post_url(data)
      return
    )

  robot.respond /ptt boards/i, (msg) ->
    msg.send "ptt boards: #{boards.join(',')}"