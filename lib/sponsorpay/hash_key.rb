require "digest/sha1"

module Sponsorpay
  module HashKey
    JOIN_CHAR = "&"

    # Computes Security Hash Key for Sponsorpay Api parameters
    def compute_hashkey api_key, params
      joined_params = params.sort.map do |k,v|
        "#{k}=#{v}"
      end.join(JOIN_CHAR)
      Digest::SHA1.hexdigest "#{joined_params}#{JOIN_CHAR}#{api_key}"
    end
  end
end