require 'active_attr'

# Simple validation for sponsorpay params
class SponsorpayParams
  include ActiveAttr::Model

  attribute :uid
  attribute :pub0
  attribute :page

  validates_presence_of :uid
  validates_presence_of :pub0
  validates_presence_of :page
end