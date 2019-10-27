class ReservationCreator

  def initialize(params)
    @params = params
  end

  def call
    @reservation = Reservation.create(reservation_params)
    @reservation.status = 0
    @params[:tickets].each do |ticket|
      ticket_kind = Ticket.find(ticket[:ticket_id])
      ReservationDetail.create(
                            ticket: ticket_kind,
                            reservation: @reservation,
                            quantity: ticket[:quantity])

      ticket_kind.update(quantity: ticket_kind.quantity - ticket[:quantity].to_i)
    end
    @reservation
  end

  private

  def reservation_params
    @params.permit(:email, :event_id)
  end
end