require 'rails_helper'

RSpec.describe Notification::EmailData, type: :model do
  use_vcr_cassette 'notification/fetch_emails_persisted', api_base_urls
  use_vcr_cassette 'notification/fetch_emails_not_persisted', api_base_urls
  use_vcr_cassette 'notification/fetch_emails_nonexistent_owner', api_base_urls

  let(:contact) { FactoryGirl.create :contact, owner_mkey: 'ZcAK4dM9S4m0IFui6ok6' }
  let(:notification) do
    FactoryGirl.create :notification, compiled_content: 'Hello from Russia!', contact: contact
  end
  let(:instance) { described_class.new notification }

  describe '#get' do
    subject { instance.get }

    it do
      is_expected.to eq to: 'vano468@gmail.com',
                        from: 'support@zazoapp.com',
                        subject: "#{contact.display_name} joined Zazo!",
                        body: 'Hello from Russia!'
    end
  end

  describe 'validations' do
    subject { instance.valid? }
    before  { subject }

    context 'when valid' do
      it { is_expected.to be true }
    end

    context 'when invalid: email not persisted' do
      let(:contact) { FactoryGirl.create :contact, owner_mkey: 'XqUn9Fs5YHd75l1rin76' }

      it { is_expected.to be false }
      it { expect(instance.errors.messages[:email]).to eq ['can\'t be blank'] }
    end

    context 'when invalid: content is not persisted' do
      let(:notification) { FactoryGirl.create :notification, contact: contact }

      it { is_expected.to be false }
      it { expect(instance.errors.messages[:content]).to eq ['can\'t be blank'] }
    end

    context 'when invalid: owner mkey is invalid' do
      let(:contact) { FactoryGirl.create :contact, owner_mkey: 'xxxxxxxxxxxx' }

      it { is_expected.to be false }
      it { expect(instance.errors.messages[:response]).to eq [{ 'user' => ['can\'t be blank'] }] }
    end
  end
end