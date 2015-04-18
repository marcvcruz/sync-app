class EventsController < ApplicationController
  before_filter :get_event, only: [:new, :create]

  def index
    @events = Event.all
  end

  def new
  end

  def create
    if @event.save
      flash.now[:notice] = t :event_successfully_created
      redirect_to :events and return
    end
    flash.now[:alert] = t :error_occurred_processing_last_request
    render :new
  end

  def edit
  end

  def update
  end

  private

  def event_params
    params.fetch(:event, {}).permit!
  end

  def get_event
    @event = Event.new event_params.reverse_merge!(organizer_id: current_user.id)
  end
end
