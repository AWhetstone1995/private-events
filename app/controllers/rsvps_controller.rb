class RsvpsController < ApplicationController
  def create
    # event = Event.find(params[:event_id])
    # user = current_user
    @rsvp = Rsvp.new(event_id: params[:event_id], user_id: current_user.id)

    if @rsvp.save
      flash[:notice] = "You have succesfully enrolled for the event"
      redirect_to event_path(params[:event_id])
    else
      flash[:alert] = "Something went wrong"
      render event_path(params[:event_id])
    end
  end

  def destroy
    # debugger
    event = Event.find(params[:event_id])
    rsvp = Rsvp.find_by(event_id: event.id, user_id: current_user.id)
    rsvp.destroy
    flash[:notice] = "You have cancelled this upcoming event."
    redirect_to event_path(rsvp.event)
  end

  private

  def enrollment_params
    params.require(:rsvp).permit(:event_id, :user_id)
  end
end
