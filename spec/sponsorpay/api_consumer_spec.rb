require 'spec_helper'
require 'sponsorpay/api_consumer'
require 'sponsorpay/hash_key_shared_examples'
require 'sponsorpay/signed_response_shared_examples'

describe Sponsorpay::ApiConsumer do
  
  describe "#get_response" do
    context "without required parameters" do
      it "should raise error if api key has not been set" do
        Sponsorpay::ApiConsumer.api_key = nil
        expect do
          Sponsorpay::ApiConsumer.get_response 1,2,3
        end.to raise_error(RuntimeError)
      end
    end

    context "witht valid parameters" do
      use_vcr_cassette

      before(:each) do
        Sponsorpay::ApiConsumer.stub!(:request_time) { '1344857943' }
        Sponsorpay::ApiConsumer.api_key = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
        Sponsorpay::ApiConsumer.params = {
          appid: 157,
          format: 'json',
          device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
          locale: 'de',
          ip: '109.235.143.113',
          offer_types: 112
        }
      end

      subject { Sponsorpay::ApiConsumer.get_response(uid, pub0, page) }

      let(:uid) { 'player1' }
      let(:pub0) { 'campaign2' }
      let(:page) { '1' }

      it "should not raise any error" do
        expect { Sponsorpay::ApiConsumer.get_response(uid, pub0, page) }.to_not raise_error
      end

      it "should get an OK response" do
        subject.should have_key('code')
        subject['code'].should eql 'OK'
        subject.headers["X-Sponsorpay-Response-Code"].should eql 'OK'
      end

      it "should return 22 offers" do
        subject['offers'].count.should eql 22
      end
    end

    context "with tampered response" do
      use_vcr_cassette

      before(:each) do
        Sponsorpay::ApiConsumer.stub!(:request_time) { '1344857943' }
        Sponsorpay::ApiConsumer.api_key = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
        Sponsorpay::ApiConsumer.params = {
          appid: 157,
          format: 'json',
          device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
          locale: 'de',
          ip: '109.235.143.113',
          offer_types: 112
        }
      end

      subject { Sponsorpay::ApiConsumer }

      let(:uid) { 'player1' }
      let(:pub0) { 'campaign2' }
      let(:page) { '1' }


      it "should raise error" do
        stub_request(:get, /api\.sponsorpay\.com/).to_return File.new("spec/webmock/tampered_response_count.txt")
        expect { subject.get_response(uid, pub0, page) }.to raise_error(RuntimeError)
      end
    end

  end

  it_should_behave_like Sponsorpay::HashKey
  it_should_behave_like Sponsorpay::SignedResponse
end