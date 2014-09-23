require 'sinatra'
require 'twilio-ruby'
require 'sinatra/run-later'
require './giphy.rb'

include Giphy

post '/sms' do

  inbound_number = params['From']
  query = params['Body']

  run_later do
    gif_url = random_gif_url(query)
    if gif_url.nil?
      send_404(inbound_number, query)
    else
      body = "Powered by Giphy.com and Twilio MMS: twilio.com/mms"
      send_gif(inbound_number, body, gif_url)
    end
  end

  content_type "text/xml"
  "<Response><Message>Be right back... grabbing a GIF of #{query} from Giphy.</Message></Response>"
end

def send_404(inbound_number, query)
  gif_url = "http://media2.giphy.com/media/JPayEyQPRCUTe/giphy.gif"
  body = "Hmmm, that's odd. I couldn't find anything for '#{query}'. Try something else?"
  send_gif(inbound_number, body, gif_url)
end

def send_gif(inbound_number, body, gif_url)
  twilio_client.account.messages.create(
    to: inbound_number,
    from: ENV['TWILIO_PHONE_NUMBER'],
    body: body,
    media_url: gif_url
  )
end

def twilio_client
  Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
end



