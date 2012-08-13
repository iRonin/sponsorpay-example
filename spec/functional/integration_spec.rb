$:.push File.expand_path("app")
require 'app'
require 'spec_helper'
require 'rack/test'

set :environment, :test

describe SponsorPayExampleApp do
  include Rack::Test::Methods

  def app
    SponsorPayExampleApp
  end

  context "GET /" do
    it "should render API Params form with uid, pub0 and page input fields" do
      get '/'
      last_response.should be_ok
      last_response.body.should match /<form.+action="\/offers"/
      last_response.body.should match /<input.+name="uid"/
      last_response.body.should match /<input.+name="pub0"/
      last_response.body.should match /<input.+name="page"/
      last_response.body.should_not match /Please fill in fields marked in red/
    end
  end

  context "POST /offers" do
    it 'should render offers page' do
      post '/offers', {}
      last_response.should be_ok
    end
    context "with missing uid parameter" do
      it "should display error message" do
        post '/offers', {pub0:123, page:123}
        last_response.body.should match /Please fill in fields marked in red/
      end
    end
    context "with missing pub0 parameter" do
      it "should display error message" do
        post '/offers', {uid:123, page:123}
        last_response.body.should match /Please fill in fields marked in red/
      end
    end
    context "with missing page parameter" do
      it "should display error message" do
        post '/offers', {pub0:123, uid:123}
        last_response.body.should match /Please fill in fields marked in red/
      end
    end
    context "with valid parameters" do
      use_vcr_cassette

      it "should display 'Fetched offers'" do
        Sponsorpay::ApiConsumer.stub!(:request_time) { '1344882693' }
        post '/offers', {uid:'player1', pub0:'campaign2', page:1}
        last_response.body.should match /Fetched offers/
      end
    end
  end
end