class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks
    validates :name, :ticker, presence:true
    def self.new_lookup(ticker_symbol)
            publish = 'pk_890cffe62a60496f824f12575cf8b52a'
            secret = 'sk_457acbc9f6a8404297e83b49578bcbd1'
            client = IEX::Api::Client.new(
                publishable_token: publish,
                secret_token: secret,
                endpoint: 'https://cloud.iexapis.com/v1'
            )
            # client.quote(ticker_symbol).latest_price
            # p client.quote(ticker_symbol)
            begin
                obj = new(ticker:ticker_symbol, name:client.quote(ticker_symbol).company_name, last_price:client.quote(ticker_symbol).latest_price)
                return obj
            rescue=>exception
                return nil
            end
            
    end
    def self.checkStock(ticker_symbol)
        where(ticker:ticker_symbol).first
    end

end
