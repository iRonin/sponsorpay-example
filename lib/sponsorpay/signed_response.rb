module Sponsorpay
  module SignedResponse

    def response_signature_valid? api_key, response_body, signature
      signature == compute_response_signature(api_key, response_body)
    end

    private

    def compute_response_signature api_key, response_body
      Digest::SHA1.hexdigest "#{response_body}#{api_key}"
    end
  end
end