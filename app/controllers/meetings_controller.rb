class MeetingsController < ApplicationController
  skip_before_action :verify_authenticity_token # so we can easily test using CURL

  def new
    @meeting_form = MeetingForm.new
  end

  def create
    response = EventSourced::Meeting.schedule(schedule_meeting_params.to_h.symbolize_keys)

    puts "In create #{response}"

    if response.success?
      render :json => { :meeting => response.data }
    else
      render :json => { :errors => response.errors }
    end
  end

  def accept
    meeting_id = accept_meeting_params[:meeting_id]

    response = EventSourced::Meeting
      .get(meeting_id)
      .accept(user_id: accept_meeting_params[:user_id])

    flash[:alert] = "Failed to accept the meeting"if response.failure?
    redirect_to meeting_path(meeting_id)
  end

  private

  def schedule_meeting_params
    params.require(:meeting).permit(:time, :organizer_id, invitee_ids: [])
  end

  def accept_meeting_params
    params.require(:accept_form).permit(:meeting_id, :user_id)
  end
end