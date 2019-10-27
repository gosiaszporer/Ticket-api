namespace :custom do
  desc "changes status of reservation to 'exceeded'"

  task remove_reservations: :environment do
    exceeded_reservations = Reservation.select { |r| r.time_limit <= Time.now && r.status != 'accepted' && r.status != 'exceeded'}
    exceeded_reservations.each do |reservation| 
      reservation.update(status: "exceeded")
      reservation.reservation_details.each do |detail|
        ticket = Ticket.find(detail.ticket_id)
        ticket.update(quantity: ticket.quantity + detail.quantity)
      end
    end
  end
end
