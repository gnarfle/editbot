require 'rubygems'
require 'bundler/setup'
require 'yaml'

Bundler.require(:default)

BOT = RedditBot::Bot.new YAML.load(File.read "secrets.yml"), ignore_captcha: true
SUBREDDIT = "eugene"

words = YAML.load(File.read "words.yaml")
checked = []
loop do
  puts "LOOP #{Time.now}"

  BOT.json(:get, "/r/#{SUBREDDIT}/about/edited")["data"]["children"].each do |post|
    id, url, title, subreddit, body = post["data"].values_at(*%w{ id permalink title subreddit body })
    next if checked.include? id
    checked.push id
    puts "#{body}"
    if body && words.any? {|w| body.downcase.match? w}
      TerminalNotifier.notify(body,
        {
          title: "Edited Reddit Post",
          open: "https://reddit.com/#{url}",
        }
      )
    end
    ### delete
    # BOT.json :post, "/api/remove",
    #   id: "t3_#{id}",
    #   spam: false
    ### modmail
    # BOT.json :post, "/api/compose",
    #   subject: "possible screenshot detected",
    #   text: "please, investigate: #{redd_it}",
    #   to: "/r/#{SUBREDDIT}"

  end or puts "/r/#{SUBREDDIT} seems to be 403-ed"

  puts "END LOOP #{Time.now}"
  sleep 10
end
