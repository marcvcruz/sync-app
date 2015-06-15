class EventsController < ApplicationController
  before_filter :get_event, only: [:edit, :update, :delete]

  def index
    @events = Event.occurring_same_month_as start_date
    respond_to do |format|
      format.html
      format.json { render json: @events, each_serializer: EventSerializer, root: false }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params.merge!(organizer_id: current_user.id)
    if @event.valid? and @event.save
      flash[:notice] = t :event_successfully_created
      redirect_to :events and return
    end
    flash.now[:alert] = t :error_occurred_processing_last_request
    render :new
  end

  def edit
  end

  def update
    if @event.update_attributes event_params
      flash[:notice] = t :event_successfully_updated
      redirect_to monthly_calendar_path(@event.year, @event.month) and return
    end
    flash.now[:alert] = t :error_occurred_processing_last_request
    render :edit
  end

  def destroy
    Event.destroy params[:id]
    flash[:notice] = t :event_successfully_deleted
    redirect_to :events and return
  end

  helper_method def start_date
    Date.civil params[:year].to_i, params[:month].to_i rescue Date.today
  end

  private

  def event_params
    params.require(:event).permit(:description, :is_all_day, :starting_on, :starting_at, :notes)
  end

  def get_event
    @event = Event.find params[:id]
  end
end
