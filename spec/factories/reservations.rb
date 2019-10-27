FactoryBot.define do
  factory :reservation do
    email { Faker::Internet.email }
    status 'pending'
    event_id nil
    
    Ticket.create(name: 'standing', price: 10, quantity: 500)
    ReservationDetail.create(ticket: Ticket.first, reservation: Reservation.first, quantity: 1)
  end
end