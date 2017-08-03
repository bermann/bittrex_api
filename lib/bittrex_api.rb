require 'bittrex_api/version'
require 'rest-client'
require 'openssl'
require 'addressable/uri'

module BittrexApi
  class << self
    attr_accessor :configuration
  end

  def self.setup
    @configuration ||= Configuration.new
    yield( @configuration )
  end

  class Configuration
    attr_accessor :key, :secret

    def initialize
      @key = ''
      @secret = ''
    end
  end

  def self.markets
    get_public 'getmarkets'
  end

  def self.currencies
    get_public 'getcurrencies'
  end

  def self.ticker( currency_pair )
    get_public 'getticker', market: currency_pair
  end

  def self.market_summaries
    get_public 'getmarketsummaries'
  end

  def self.market_summary( currency_pair )
    get_public 'getmarketsummary', market: currency_pair
  end

  def self.order_book( currency_pair, type = 'both', depth = 10 )
    get_public 'getorderbook', market: currency_pair, type: type, depth: depth
  end

  def self.market_history( currency_pair )
    get_public 'getmarkethistory', market: currency_pair
  end

  def self.buy_limit( currency_pair, quantity, rate )
    get_market 'buylimit', market: currency_pair, quantity: quantity, rate: rate
  end

  def self.sell_limit( currency_pair, quantity, rate )
    get_market 'selllimit', market: currency_pair, quantity: quantity, rate: rate
  end

  def self.cancel( uuid )
    get_market 'cancel', uuid: uuid
  end

  def self.open_orders( currency_pair = nil )
    get_market 'getopenorders', market: currency_pair
  end

  def self.balances
    get_account 'getbalances'
  end

  def self.balance( currency )
    get_account 'getbalance', currency: currency
  end

  def self.deposit_address( currency )
    get_account 'getdepositaddress', currency: currency
  end

  def self.withdraw( currency, quantity, address )
    get_account 'withdraw', currency: currency, quantity: quantity,
      address: address
  end

  def self.order( uuid )
    get_account 'getorder', uuid: uuid
  end

  def self.order_history( currency_pair = nil )
    get_account 'getorderhistory', market: currency_pair
  end

  def self.withdrawal_history( currency = nil )
    get_account 'getwithdrawalhistory', currency: currency
  end

  def self.deposit_history( currency = nil )
    get_account 'getdeposithistory', currency: currency
  end

  private
  def self.make_full_url( method, command, params )
    url = "https://bittrex.com/api/v1.1/#{method}/#{command}"
    query = params.delete_if{ |k,v| v.nil? }.map{ |k,v| "#{k}=#{v}" }.join '&'
    "#{url}?#{query}"
  end

  def self.signature( url )
    OpenSSL::HMAC.hexdigest('sha512', configuration.secret.encode("ASCII"),
                            url.encode("ASCII"))
  end

  def self.get_public( command, params = {} )
    get 'public', command, params
  end

  def self.get_market( command, params = {} )
    get 'market', command, params
  end

  def self.get_account( command, params = {} )
    get 'account', command, params
  end

  def self.get( method, command, params )
    if method != 'public'
      params['apikey'] = configuration.key
      params['nonce'] = Time.now.to_i
    end
    full_url = make_full_url(method, command, params)
    if method == 'public'
      RestClient.get(full_url)
    else
      sig = signature(full_url)
      RestClient.get(full_url, apisign: sig)
    end
  end
end
