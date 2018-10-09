class JokesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @joke = Joke.new
  end

  def create
    @joke = Joke.new(joke_params)
    @joke.user = current_user
    @joke.save
    flash[:notice] = "Your joke has been submitted!"
    redirect_to home_jokes_path
  end

  def update
    @joke = Joke.friendly.find(params[:id])
    if @joke.update_attributes(joke_params)
      flash[:notice] = "Bam! You just made funny happen."
      redirect_to home_jokes_path
    else
      flash[:alert] = "Something went terribly wrong there..."
      render :action => :edit
    end
  end

  def edit
    @joke = Joke.friendly.find(params[:id])
    @joke.save
  end

  def destroy
    @joke = Joke.friendly.find(params[:id])
    @joke.destroy
    flash[:alert] = "Poof! That joke is no more."
    redirect_to home_jokes_path
  end

  def show
    @joke = Joke.friendly.find(params[:id])
  end

  def index
    @jokes = Joke.all.plusminus_tally.order("plusminus_tally DESC")
    @unapproved_jokes = Joke.where(approved: false, rejected: false)
  end

  def approve
    @joke = Joke.friendly.find(params[:id])
    @joke.update_attributes(approved: true)
    @joke.user.manpoints += 5
    @joke.save
    @joke.user.save
    redirect_to jokes_path
  end

  def reject
    @joke = Joke.friendly.find(params[:id])
    @joke.update_attributes(rejected: true)
    @joke.user.manpoints -= 5
    @joke.save
    @joke.user.save
    redirect_to jokes_path
  end

  def vote_up
    @joke = Joke.friendly.find(params[:id])

    if !current_user.voted_on?(@joke)
      current_user.vote_for(@joke)
      @joke.user.manpoints += 5
      @joke.user.save

       #proper rails api endpoint
      render json: {success: "Yay"}
    end
  end

  def vote_down
    @joke = Joke.friendly.find(params[:id])


    if !current_user.voted_on?(@joke)
      current_user.vote_against(@joke)
      @joke.user.manpoints -= 5
      @joke.user.save
      respond_to do |format|
         format.js
      end
    end
  end

  private

  def joke_params
    params.require(:joke).permit(:user, :title, :body, :joke_type, :approved, :rejected, :rank)
  end
end
