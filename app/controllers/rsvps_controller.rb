class RsvpsController < ApplicationController
#   before_action :require_login

  def create
    event = Event.find(params[:event_id])
    user = current_user
    rsvp = Rsvp.new(event_id: event.id, user_id: user.id)

    if rsvp.save
      flash[:notice] = "You have succesfully enrolled for the event"
      redirect_to event_path(event)
    else
      flash[:alert] = "Something went wrong"
      render event_path(event)
    end
  end

  def destroy
    rsvp = Rsvp.find(params[:id])
    rsvp.destroy
    redirect_to event_path(rsvp.event)
  end
  
  def update
    event = Event.find(params[:event_id])
    user = current_user
    if Rsvp.where(event_id: event.id, user_id: user.id).exists?
      Rsvp.destroy(Rsvp.where(event_id: event.id, user_id: user.id).first.id)
    else
      Rsvp.create(event_id: event.id, user_id: user.id)
      redirect_to event_path(event)
    end
  end

#   def new
#     @event = current_user.build
#   end
  private

  def enrollment_params
    params.require(:rsvp).permit(:event_id, :user_id)
  end
end
