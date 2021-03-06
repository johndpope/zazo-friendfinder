require 'spec_helper'

describe WebClientDecorator do
  let(:contact) { create(:contact) }
  let(:notification) { create(:notification, contact: contact) }
  let(:web_client) { WebClient::ActionHandler.new(notification.nkey) }
  let(:instance) { described_class.decorate(web_client) }

  describe '#others_contacts' do
    let(:another_contact_1) { create(:contact_as_not_friend, owner_mkey: contact.owner.mkey, total_score: 4) }
    let(:another_contact_2) { create(:contact_as_not_friend, owner_mkey: contact.owner.mkey, total_score: 6) }
    let(:another_contact_3) { create(:contact_as_not_friend, owner_mkey: contact.owner.mkey, total_score: 5) }
    let(:another_contact_4) { create(:contact_as_not_friend, owner_mkey: contact.owner.mkey, total_score: 3) }

    subject { instance.others_contacts }

    it do
      expected = [2, 3, 1].map { |num| send("another_contact_#{num}") }
      is_expected.to eq expected
    end
  end
end
