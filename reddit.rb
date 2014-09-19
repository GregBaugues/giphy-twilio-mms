require "ruby_reddit_api"
require 'pry'

module RedditGif

  def random_gif
    reddit_gifs.sample
  end

  def reddit_gifs(limit = 100)
    reddit_client.browse('gifs', limit: limit).
      select { |r| r.url.include?('.gif') }.
      collect { |r| reddit_to_gif_hash(r) }
  end

  def reddit_client
    Reddit::Api.new "mmsbot", "drawtheowl"
  end

  def reddit_to_gif_hash(r)
    {url: r.url, title: r.title, permalink: shortened_url(r.permalink) }
  end

  def reddit_id(permalink)
    permalink.match(/comments\/(\w*)\//)[1]
  end

  def shortened_url(permalink)
    "redd.it/" + reddit_id(permalink)
  end
end
