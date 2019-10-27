class TicketsController < ApplicationController

   # GET /events/:id/tickets
  def index
    @tickets = Ticket.all
    json_response(@tickets)
  end
end
