require_relative 'hash_key'
require_relative 'signed_response'
require 'httparty'

module Sponsorpay
  class ApiConsumer
    include HTTParty

    base_uri "http://api.sponsorpay.com"

    class << self
      include HashKey
      include SignedResponse

      attr_accessor :api_key
      attr_accessor :params

      def get_response uid, pub0, page
        raise "Api Key has not been set" if @api_key.nil?
        params = @params.merge({
          uid: uid,
          pub0: pub0,
          page: page,
          :timestamp => request_time
        })
        response = get "/feed/v1/offers.#{params[:format]}", query: params.merge({
          hashkey: compute_hashkey(@api_key, params)
        })
        raise "Response has been tampered!" if !response_signature_valid? @api_key, response.body, get_response_signature(response)
        response
      end

      def request_time
        Time.now.to_i
      end

      # We need to symbolize keys because Sinatra loads config file without indifferent access…
      def params= params
        new_hash = Hash.new
        params.each do |key, value|
          new_hash[key.to_sym] = value
        end
        @params = new_hash
      end

      private 

      def get_response_signature response
        response.header['X-Sponsorpay-Response-Signature']
      end
    end
  end
end