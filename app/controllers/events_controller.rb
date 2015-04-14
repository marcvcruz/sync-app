class EventsController < ApplicationController
  def index
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    @event.organizer = current_user
    redirect_to :events and return if @event.valid? and @event.save

    flash.now[:error] = t :error_occurred_processing_last_request
    render :new
  end

  def edit
  end

  def update
  end

  private

  def event_params
    params.require(:event).permit!
  end

end
