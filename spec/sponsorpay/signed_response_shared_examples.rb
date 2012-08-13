shared_examples_for Sponsorpay::SignedResponse do
  
  describe '#response_signature_valid?' do
    let(:api_key) { 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f' }
    let(:signature) { 'd01e10856431b1f0b842f0e6135d67307a1de6ce' }
    
    context "for valid response" do
      let(:response) do
        File.new(File.expand_path('signed_response.json', File.dirname(__FILE__)), 'r').read
      end    
      it "should return true" do
        described_class.response_signature_valid?(api_key, response, signature).should be_true
      end
    end

    context "for tampered response" do
      let(:response) do
        File.new(File.expand_path('signed_response_tampered.json', File.dirname(__FILE__)), 'r').read
      end    
      it "should return false" do
        described_class.response_signature_valid?(api_key, response, signature).should be_false
      end
    end

  end

end