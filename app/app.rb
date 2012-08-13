require 'sinatra'
require "sinatra/config_file"
require 'slim'

require 'models/sponsorpay_params'
require 'sponsorpay/api_consumer'

class SponsorPayExampleApp < Sinatra::Application
  register Sinatra::ConfigFile

  configure do
    set :static, true
    set :slim, :layout_engine => :slim, :layout => :layout, :pretty => true
    set :partial_template_engine, :slim
  end

  configure :development do
     require "sinatra/reloader"
     register Sinatra::Reloader
     also_reload '**/*.rb'
   end

  helpers do
    def control_group_error_class show_error_class
      "error" if show_error_class
    end
  end

  config_file '../config/config.yml'

  get '/' do
    @api_params = SponsorpayParams.new
    slim :index
  end

  post '/offers' do
    @api_params = SponsorpayParams.new params
    @params_valid = @api_params.valid?
    @uid_error = @api_params.errors.messages[:uid]
    @pub0_error = @api_params.errors.messages[:pub0]
    @page_error = @api_params.errors.messages[:page]
    if @params_valid
      Sponsorpay::ApiConsumer.api_key = settings.sponsorpay['api_key']
      Sponsorpay::ApiConsumer.params = settings.sponsorpay['params']
      resp = Sponsorpay::ApiConsumer.get_response params[:uid], params[:pub0], params[:page]
      @offers = resp['offers']
      slim :offers
    else
      slim :index
    end
  end
end