require 'spec_helper'
require 'models/sponsorpay_params'

describe SponsorpayParams do
  context "after initialization" do
    subject { SponsorpayParams.new }

    specify { subject.should respond_to(:uid)}
    specify { subject.should respond_to(:pub0)}
    specify { subject.should respond_to(:page)}
    specify { subject.should_not be_valid}
  end

  context "with values" do
    subject { FactoryGirl.build(:sponsorpay_params) }

    it "shouldn't be valid when uid is not present" do
      subject.uid = ''
      subject.should_not be_valid
    end

    it "shouldn't be valid when pub0 is not present" do
      subject.pub0 = ''
      subject.should_not be_valid
    end

    it "shouldn't be valid when page is not present" do
      subject.page = ''
      subject.should_not be_valid
    end

    it "should be valid with uid, pub0, page present" do
      subject.should be_valid
    end
  end
end