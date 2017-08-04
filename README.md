# BittrexApi

[![Gem Version](https://badge.fury.io/rb/poloniex.png)](http://badge.fury.io/rb/poloniex)

This gem provides a ruby wrapper to the bittrex.com api: [Link](https://bittrex.com/home/api).

It was inspired by the Poloniex gem [Link](https://github.com/Lowest0ne/poloniex).

## Installation

Add this line to your application's Gemfile:

    gem 'bittrex_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bittrex_api

## Usage

All methods provided by ```BittrexApi``` are class methods, and are of the same name as the api ( except that "get"s have been removed ).

For example, ```https://bittrex.com/api/v1.1/public/getmarkets``` is written as ```BittrexApi.markets```

The BittrexApi module accepts a setup block for configuration:

```
BittrexApi.setup do | config |
    config.key = 'my api key'
    config.secret = 'my secret token'
end
```

GET requests ( to public ) do not need authentication, and therefor do not need Bittrex to be configured.

GET requests ( to market and account ) will need authentication, and you will have to have your own key and secret token.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Donating

Any donation will be very welcome 

BTC address: 17e9toPoPHwfDEXbCxxgVAS7GyzsR1smHZ
