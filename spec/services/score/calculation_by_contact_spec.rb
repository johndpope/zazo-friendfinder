require 'rails_helper'

RSpec.describe Score::CalculationByContact do
  let(:contact) { FactoryGirl.create :contact, vectors: vectors }
  let(:instance) { described_class.new contact }

  describe '#do' do
    let(:vectors) {[
      FactoryGirl.create(:vector_mobile, additions: { sms_messages_sent: 12 }),
      FactoryGirl.create(:vector_email, additions: { marked_as_favorite: true })
    ]}
    before do
      FactoryGirl.create :contact, vectors: [FactoryGirl.create(:vector_email, value: vectors.last.value)]
    end
    let!(:subject) { instance.do }

    it { is_expected.to be true }
    it { expect(Score.all.size).to eq 6 }
    it { expect(contact.reload.total_score).to eq 33 }
  end
end