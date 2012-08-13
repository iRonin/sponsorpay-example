shared_examples_for Sponsorpay::HashKey do

  describe "#compute_hashkey" do

    context 'for predefined valid parameters' do

      let(:api_key) { 'e95a21621a1865bcbae3bee89c4d4f84' }

      let(:params) do
        {
          appid: 157,
          uid: 'player1',
          ip: '212.45.111.17',
          locale: 'de',
          device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
          ps_time: '1312211903',
          pub0: 'campaign2',
          page: 2,
          timestamp: 1312553361
        }
      end

      it "should compute hash of value '7a2b1604c03d46eec1ecd4a686787b75dd693c4d'" do
        described_class.compute_hashkey(api_key, params).should eql('7a2b1604c03d46eec1ecd4a686787b75dd693c4d')
      end

    end

  end
  
end