class SuggestionsController < ApplicationController
  invisible_captcha only: [:create], honeypot: :subtitle

  def index
    @suggestions = Suggestion.where(archived: false)
    @archived_suggestions = Suggestion.where(archived: true)
  end

  def archives
    @suggestions = Suggestion.where(archived: true)
    @current_suggestions = Suggestion.where(archived: false)
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.user = current_user
    @suggestion.save
    flash[:notice] = "So stipulated. Your suggestion will be considered by the powers that be."
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy
    flash[:alert] = "Good riddance!"
    redirect_to suggestions_path
  end

  def archive
    @suggestion = Suggestion.find(params[:id])
    @suggestion.update_attributes(archived: true)
    @suggestion.save
    flash[:notice] = "*Dusts off hands*  That suggestion's all taken care of!"
    redirect_to suggestions_path
  end

  def unarchive
    @suggestion = Suggestion.find(params[:id])
    @suggestion.update_attributes(archived: false)
    @suggestion.save
    flash[:notice] = "Sigh, I guess that one still needs a little TLC..."
    redirect_to suggestions_archives_path
  end


  private

  def suggestion_params
    params.require(:suggestion).permit(:user, :suggestion, :page, :archived)
  end
end
