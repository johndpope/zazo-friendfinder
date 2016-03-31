require 'rails_helper'

RSpec.describe Notification::Send do
  let(:instance) { described_class.new(notification) }
  let(:notification) { FactoryGirl.create(:notification, kind: kind, contact: contact) }

  describe '#do' do
    #
    # email notification
    #

    context 'when email notification' do
      let(:kind) { 'email' }
      subject { notification.reload.state }

      context 'when contact owner is existing zazo user with persisted emails' do
        let(:contact) { FactoryGirl.create(:contact, owner_mkey: 'GBAHb0482YxlJ0kYwbIS') }
        before { instance.do }

        it { is_expected.to eq 'sent' }
      end

      context 'when contact owner is existing zazo user without persisted emails' do
        let(:contact) { FactoryGirl.create(:contact, owner_mkey: 'XqUn9Fs5YHd75l1rin76') }
        before { instance.do }

        it { is_expected.to eq 'canceled' }
      end

      context 'when contact owner is not exist' do
        let(:contact) { FactoryGirl.create(:contact, owner_mkey: 'xxxxxxxxxxxx') }
        before { instance.do }

        it { is_expected.to eq 'canceled' }
      end

      context 'when email is not correct' do
        let(:contact) { FactoryGirl.create(:contact, owner_mkey: 'dz4X0EvprPJO6fGysT8X') }
        before { instance.do }

        it { is_expected.to eq 'error' }
      end
    end

    #
    # mobile notification
    #

    context 'when mobile notification' do
      let(:kind) { 'mobile' }
      subject { notification.reload.state }

      context 'when contact owner is existing zazo push_user' do
        let(:contact) { FactoryGirl.create(:contact, owner_mkey: 'GBAHb0482YxlJ0kYwbIS') }
        before { instance.do }

        it { is_expected.to eq 'sent' }
      end

      context 'when contact owner is not existing zazo push_user' do
        it
      end
    end
  end
end
