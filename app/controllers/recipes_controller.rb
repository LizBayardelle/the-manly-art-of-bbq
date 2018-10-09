class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.photo.attach(params[:photo])
    @recipe.save
    flash[:notice] = "Your recipe has been submitted!"
    redirect_to recipe_path(@recipe)
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      flash[:notice] = "Mmmmm... That sounds good!"
      redirect_to recipe_path
    else
      flash[:alert] = "Something went terribly wrong there..."
      render :action => :edit
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    # @recipe.photo.attach(params[:photo])
    @recipe.save
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:alert] = "Like good BBQ, that recipe's all gone."
    redirect_to home_bbq_path
  end

  def index
    @recipes = Recipe.all
    @unapproved_recipes = Recipe.where(approved: false, rejected: false)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def approve
    @recipe = Recipe.find(params[:id])
    @recipe.update_attributes(approved: true)
    @recipe.user.manpoints += 5
    @recipe.save
    @recipe.user.save
    redirect_to recipes_path
  end

  def reject
    @recipe = Recipe.find(params[:id])
    @recipe.update_attributes(rejected: true)
    @recipe.user.manpoints -= 5
    @recipe.save
    @recipe.user.save
    redirect_to recipes_path
  end

  def vote_up
    @recipe = Recipe.find(params[:id])
    if !current_user.voted_on?(@recipe)
      current_user.vote_for(@recipe)
      @recipe.user.manpoints += 5
      @recipe.user.save

      respond_to do |format|
        format.js
      end
    end
  end

  def vote_down
    @recipe = Recipe.find(params[:id])
    if !current_user.voted_on?(@recipe)
      current_user.vote_against(@recipe)
      @recipe.user.manpoints -= 5
      @recipe.user.save

      respond_to do |format|
        format.js
      end
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:user, :name, :teaser, :instructions, :beef, :chicken, :fish, :other_meat, :veggies, :approved, :rejected, :rankpoints, :photo)
  end
end
