require 'json'
require 'net/http'
require 'pry'
require 'open-uri'

module Giphy

  def giphy_api_key
    ENV['GIPHY_API_KEY']
  end

  def giphy_search_url(query)
    query.gsub!(' ', '+')
    "http://api.giphy.com/v1/gifs/search?q=#{query}&api_key=#{giphy_api_key}"
  end

  def get_image_data(query)
    file = open(giphy_search_url(query))
    JSON.parse(file.read)
  end

  def gif_urls(data)
    data['data'].collect { |gif| gif['images']['downsized']['url'] }
  end

  def random_gif_url(query)
    data = get_image_data(query)
    gif_urls(data).sample
  end

end