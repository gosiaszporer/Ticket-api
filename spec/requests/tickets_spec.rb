require 'rails_helper'

RSpec.describe 'Tickets API', type: :request do
  let(:event) { create(:event) }
  let(:event_id) { event.id }
  let!(:tickets) { create_list(:ticket, 10, event: event) }

  describe 'GET /events/:event_id/tickets' do
    before { get "/events/#{event_id}/tickets" }

    it 'returns tickets' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end