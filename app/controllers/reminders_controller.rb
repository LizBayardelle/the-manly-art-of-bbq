class RemindersController < ApplicationController
  before_action :authenticate_user!

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.user = current_user
    @reminder.save
    flash[:notice] = "Purge it from your actual memory, we've got this one!"
    redirect_to reminders_path
  end

  def update
    @reminder = Reminder.find(params[:id])
    if @reminder.update_attributes(reminder_params)
      flash[:notice] = "Updated! You can now forget it!"
      redirect_to reminders_path
    else
      flash[:alert] = "Something went terribly wrong there..."
      render :action => :edit
    end
  end

  def edit
    @reminder = Reminder.find(params[:id])
    @reminder.save
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy
    flash[:alert] = "You're on your own now. It's all gone!"
    redirect_to reminders_path
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

  def index
    @reminders = Reminder.where(user_id: current_user.id).order('event_date ASC')
  end

  private

  def reminder_params
    params.require(:reminder).permit(:name, :user, :event_date, :mail_date, :occasion_type, :reminder, :repeating, :gift, :gift_help)
  end
end
