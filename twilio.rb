require 'sinatra'
require 'twilio-ruby'
require 'sinatra/run-later'
require './giphy.rb'

include Giphy

TWILIO_PHONE_NUMBER = '+12028001334'

post '/sms' do

  inbound_number = params['From']
  query = params['Body']

  run_later do
    gif_url = random_gif_url(query)
    if gif_url.nil?
      send_not_found(inbound_number, query)
    else
      send_gif(inbound_number, query, gif_url)
    end
  end

  content_type "text/xml"
  "<Response></Response>"
end

def send_gif(inbound_number, query)
  twilio_client.account.messages.create(
    to: inbound_number,
    from: TWILIO_PHONE_NUMBER,
    body: "Couldn't find any gifs on Giphy.com for #{query}. Try something else?"
  )
end

def send_gif(inbound_number, query, gif_url)
  twilio_client.account.messages.create(
    to: inbound_number,
    from: TWILIO_PHONE_NUMBER,
    body: msg_body(query),
    media_url: gif_url
  )
end

def twilio_client
  Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
end

def msg_body(query)
  "Powered by Giphy.com and Twilio MMS: twilio.com/mms"
end