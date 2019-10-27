class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :pay]
  before_action :set_event, only: :create

  # GET /events/:id/reservations/:id
  def show
    render :json => @reservation.to_json( :include => [:reservation_details] )
  end

  # POST /events/:id/reservations
  def create
    if params[:tickets].nil?
      return render json: { status: "error", 
                              code: 422, 
                              message: "You can't make reservation without tickets" }, 
                      status: :unprocessable_entity
    end
    all_tickets = @event.tickets.pluck(:quantity).sum
    chosen_tickets = params[:tickets].pluck(:quantity).sum

    if @event.even
      if chosen_tickets%2 != 0
        return render json: { status: "error", 
                              code: 422, 
                              message: "You need to buy a even number of tickets" }, 
                      status: :unprocessable_entity
      end
    elsif @event.all_together
      if chosen_tickets != all_tickets
        return render json: { status: "error", 
                              code: 422, 
                              message: "You need to buy all the tickets at once" }, 
                      status: :unprocessable_entity
      end
    elsif @event.avoid_one
      if all_tickets - chosen_tickets = 1
        return render json: { status: "error", 
                              code: 422, 
                              message: "You can't leave only 1 ticket" }, 
                      status: :unprocessable_entity
      end
    end
    reservation = ReservationCreator.new(params).call
    render :json => reservation.to_json( :include => [:reservation_details] ), status: :created
  end

  # PUT /events/:id/reservations/:id/pay
  def pay
    unless (params[:card_number]&.length == 16) & (params[:ccv]&.length == 3)
      return render json: { status: "error", 
                            code: 422, 
                            message: "You need to provide valid card number and ccv number" }, 
                    status: :unprocessable_entity
    end
    if @reservation.status == "exceeded"
      return render json: { status: "error", 
                            code: 422, 
                            message: "You reservation has expired" }, 
                    status: :unprocessable_entity
    end

    @reservation.update(status: 2)
    render :json => @reservation.to_json( :include => [:reservation_details] )
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
