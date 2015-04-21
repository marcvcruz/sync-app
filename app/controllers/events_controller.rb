class EventsController < ApplicationController
  before_filter :get_event, only: [:edit, :update]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params.merge!(organizer_id: current_user.id)
    if @event.valid? and @event.save
      flash.now[:notice] = t :event_successfully_created
      redirect_to :events and return
    end
    flash.now[:alert] = t :error_occurred_processing_last_request
    render :new
  end

  def edit
  end

  def update
    if @event.update_attributes event_params
      flash.now[:notice] = t :event_successfully_updated
      redirect_to :events and return
    end
    flash.now[:alert] = t :error_occurred_processing_last_request
    render :edit
  end

  private

  def event_params
    params.require(:event).permit(:description, :is_all_day, :starting_at, :notes)
  end

  def get_event
    @event = Event.find params[:id]
  end
end
