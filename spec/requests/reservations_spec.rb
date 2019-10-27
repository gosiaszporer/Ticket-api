require 'rails_helper'

RSpec.describe 'Resevation API', type: :request do
  let!(:event) { create(:event) }
  let(:event_id) { event.id }
  let!(:reservation) { create(:reservation, event: event) }
  let(:reservation_id) { reservation.id }
  let!(:tickets) { create_list(:ticket, 10, event: event) }
  let(:ticket_id) { tickets.first.id }
  let!(:even_event) { create(:event, even: true) }
  let(:even_event_id) { even_event.id }
  let!(:all_event) { create(:event, all_together: true) }
  let(:all_event_id) { all_event.id }
  let!(:avoid_event) { create(:event, avoid_one: true) }
  let(:avoid_event_id) { avoid_event.id }

  describe 'GET /events/:event_id/reservations/:reservation_id' do
    before { get "/events/#{event_id}/reservations/#{reservation_id}" }

    context 'when the record exists' do
      it 'returns the reservation' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:reservation_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Reservation with 'id'=100/)
      end
    end
  end

  describe 'POST /events/:event_id/reservations' do
    let(:valid_attributes) { { email: 'ron@hogwarts.edu', 
                               tickets: [
                                 ticket_id: ticket_id,
                                 quantity: 3] } }

    context 'when request attributes are valid' do
      before { post "/events/#{event_id}/reservations", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/events/#{event_id}/reservations", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/You can't make reservation without tickets/)
      end
    end

    context 'when even condition is not met' do
      before { post "/events/#{even_event_id}/reservations", params: valid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/You need to buy a even number of tickets/)
      end
    end

    context 'when all_together condition is not met' do
      before { post "/events/#{all_event_id}/reservations", params: valid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/You need to buy all the tickets at once/)
      end
    end

    context 'when avoid condition is not met' do
      let(:valid_attributes) { { email: 'ron@hogwarts.edu', 
                               tickets: [
                                 ticket_id: ticket_id,
                                 quantity: tickets.first.quantity - 1] } }
      before { post "/events/#{avoid_event_id}/reservations", params: valid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/You can't leave only 1 ticket/)
      end
    end
  end

  describe 'PUT /events/:event_id/reservations/:reservation_id/pay' do
    let(:valid_attributes) { { card_number: 1234567412345678, ccv: 123 } }

    context 'when request attributes are valid' do
      before { put "/events/#{event_id}/reservations/#{reservation_id}/pay", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'changes reservation status' do
        expect(JSON(response.body)["status"]).to eq("accepted")
      end
    end

    context 'when an invalid request' do
      before { put "/events/#{event_id}/reservations/#{reservation_id}/pay", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/You need to provide valid card number and ccv number/)
      end
    end
  end
end