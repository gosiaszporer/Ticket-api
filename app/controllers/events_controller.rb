class EventsController < ApplicationController
   before_action :set_event, only: :show

   # GET /events
  def index
    @events = Event.all
    json_response(@events)
  end

  # GET /events/:id
  def show
    json_response(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
