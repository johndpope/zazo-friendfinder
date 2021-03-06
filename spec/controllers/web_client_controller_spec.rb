require 'rails_helper'

RSpec.describe WebClientController, type: :controller, authenticate_with_http_basic: true do
  let(:contact) { create(:contact) }
  let(:notification) { create(:notification, contact: contact) }
  let(:nkey) { notification.nkey }
  let(:owner) { Owner.new(contact.owner_mkey) }

  render_views

  describe 'GET #show' do
    context 'with correct nkey' do
      before { get :show, id: nkey }

      it { expect(response).to have_http_status 200 }
      it { expect(response).to render_template(:show) }
    end

    context 'with incorrect nkey' do
      it { expect { get :show, id: 'xxxxxxxxxxxx' }.to raise_error(WebClient::NotFound) }
    end
  end

  describe 'GET #add' do
    before { get :add, id: nkey }

    it_behaves_like 'response redirect'
    it { expect(notification.reload.status).to eq 'added' }
  end

  describe 'GET #ignore' do
    before { get :ignore, id: nkey }

    it_behaves_like 'response redirect'
    it { expect(notification.reload.status).to eq 'ignored' }
  end

  describe 'GET #unsubscribe' do
    before { get :unsubscribe, id: nkey }

    it_behaves_like 'response redirect'
    it { expect(owner.unsubscribed?).to be true }
  end

  describe 'GET #subscribe' do
    let!(:notification) { create(:notification, contact: contact) }
    before { get :subscribe, id: notification.nkey }

    it_behaves_like 'response redirect'
    it { expect(owner.subscribed?).to be true }
  end
end
