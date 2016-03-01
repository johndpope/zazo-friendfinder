require 'rails_helper'

RSpec.describe Score::Criteria::ZazoActivity do
  let(:connection) { FactoryGirl.create :contact, zazo_mkey: mkey }
  let(:instance) { described_class.new connection }

  describe '#calculate_with_ratio' do
    subject do
      VCR.use_cassette(vcr_cassette, api_base_urls) { instance.calculate_with_ratio }
    end

    context 'with correct mkey by very active user' do
      let(:vcr_cassette) { 'score/criteria/zazo_activity_by_7qdanSEmctZ2jPnYA0a1' }
      let(:mkey) { '7qdanSEmctZ2jPnYA0a1' }

      it { is_expected.to eq 216 }
    end


    context 'with correct mkey by not very active user' do
      let(:vcr_cassette) { 'score/criteria/zazo_activity_by_GBAHb0482YxlJ0kYwbIS' }
      let(:mkey) { 'GBAHb0482YxlJ0kYwbIS' }

      it { is_expected.to eq 16 }
    end

    context 'with incorrect mkey' do
      let(:vcr_cassette) { 'score/criteria/zazo_activity_by_incorrect' }
      let(:mkey) { 'xxxxxxxxxxxx' }

      it { is_expected.to eq 0 }
    end

    context 'when user in not registered on zazo' do
      let(:vcr_cassette) { '' }
      let(:connection) { FactoryGirl.create :contact }

      it { is_expected.to eq 0 }
    end
  end

  describe '#save' do
    let(:vcr_cassette) { 'score/criteria/zazo_activity_by_7qdanSEmctZ2jPnYA0a1' }
    let(:mkey) { '7qdanSEmctZ2jPnYA0a1' }

    subject do
      VCR.use_cassette(vcr_cassette, api_base_urls) { instance.save }
    end

    it { is_expected.to be_valid }
    it { expect(subject.name).to eq 'zazo_activity' }
    it { expect(subject.persisted?).to be true }
  end
end