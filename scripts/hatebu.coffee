module.exports = (robot) ->
  # http://developer.hatena.ne.jp/ja/documents/bookmark/apis/webhook
  robot.router.post "/hubot/hatenabookmark", (req, res) ->
    body = req.body

    if channel = body.key
      username = body.username

      icon_url = "http://cdn1.www.st-hatena.com/users/#{username.substring(0,2)}/#{username}/profile.gif"
      link = "#{body.permalink}|#{body.title}> #{body.count} users"

      payload = JSON.stringify
        channel: "#" + channel,
        text: [body.comment, link].join(" "),
        username: username,
        icon_url: icon_url
      robot.http(process.env.SLACK_WEBHOOK_URL).post(payload)
    res.end()
