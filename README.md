# Animated GIFS via MMS


On the Twilio side, you'll need to sign up for a Twilio account and purchase an MMS enabled number for $1. On the Giphy side, you can build an app using the public beta key, but you'll want to get a real API key from the team before scaling to production. 

Clone this repo. Run ```bundle install``` to install the gems. Then, from a terminal set the following environment variables: 

```
export TWILIO_ACCOUNT_SID=youraccountsidhere
export TWILIO_AUTH_TOKEN=yourauthtokenhere
export TWILIO_PHONE_NUMBER=+13128675309
export GIPHY_API_KEY=yourgiphyapikey
```

Start the sinatra server: 

```
ruby twilio.rb
```

Open a tunnel to your local machine. If you [use ngrok](https://www.twilio.com/blog/2013/10/test-your-webhooks-locally-with-ngrok.html) with custom subdomains, use: 

```
./ngrok -subdomain=example 4567
```

Click on your shiny new phone number in your Twilio dashboard and set the messaging webhook to: 

```
http://example.ngrok.com/sms
```

And you should be good to go. Ping me if you have questions at [gb@twilio.com](mailto:gb@twilio.com) or [@greggyb](http://twitter.com/greggyb). 

