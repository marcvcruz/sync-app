class EventsController < ApplicationController
  before_filter :get_event, only: [:edit, :update, :delete]

  def index
    @events = Event.occurs_in start_date
    respond_to do |format|
      format.html
      format.json { render json: @events, each_serializer: EventSummarySerializer, root: false }
    end
  end

  def new
    @event = Event.new(starting_date_time: params[:starting_date])
  end

  def create
    @event = Event.new event_params.merge!(organizer_id: current_user.id)
    if @event.valid? and @event.save
      respond_to do |format|
        format.json { render json: { status: :success, root: false } and return }
      end
    end

    respond_to do |format|
      format.json { render json: { status: :error, message: t(:error_occurred_processing_last_request), root: false } and return }
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.json { render json: @event, serializer: EventSerializer, root: false}
    end
  end

  def update
    if @event.update_attributes event_params
      respond_to do |format|
        format.html {
          flash[:notice] = t :event_successfully_updated
          redirect_to monthly_calendar_path(@event.year, @event.month)
        }
        format.json { render nothing: true }
      end
    else
      flash.now[:alert] = t :error_occurred_processing_last_request
      render :edit
    end
  end

  def destroy
    Event.destroy params[:id]
    flash[:notice] = t :event_successfully_deleted
    redirect_to :events and return
  end

  helper_method def start_date
    Date.civil params[:year].to_i, params[:month].to_i
  rescue
    Date.today
  end

  private

  def event_params
    params.require(:eventForm).transform_keys { |k| k.to_s.underscore.to_sym }.permit(:description, :is_all_day, :starting_on, :starting_at, :notes)
  end

  def get_event
    @event = Event.find params[:id]
  end
end
