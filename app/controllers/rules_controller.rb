class RulesController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

  def index
    @rule = Rule.new
    @rules = Rule.where(approved: true).plusminus_tally.order("plusminus_tally DESC")
    @manrules = Rule.plusminus_tally.limit(1).offset(99)
    @manguidelines = Rule.plusminus_tally.limit(100)
    @unapproved_rules = Rule.where(approved: false, rejected: false)
    @my_unapproved_rules = Rule.where(user: current_user, approved: false, rejected: false)
  end

  def create
    @rule = Rule.new(rule_params)
    @rule.user = current_user
    @rule.save
    flash[:notice] = "Your rule has been submitted!"
    redirect_to rules_path
  end

  def update
    @rule = Rule.find(params[:id])
    if @rule.update_attributes(rule_params)
      flash[:notice] = "And it is so."
      redirect_to rules_path
    else
      flash[:alert] = "Something went terribly wrong there..."
      render :action => :edit
    end
  end

  def edit
    @rule = Rule.find(params[:id])
    @rule.save
  end

  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy
    flash[:alert] = "Good riddance!"
    redirect_to rules_path
  end

  def approve
    @rule = Rule.find(params[:id])
    @rule.update_attributes(approved: true)
    @rule.user.manpoints += 5
    @rule.save
    @rule.user.save
    redirect_to rules_path
  end

  def reject
    @rule = Rule.find(params[:id])
    @rule.update_attributes(rejected: true)
    @rule.user.manpoints -= 5
    @rule.save
    @rule.user.save
    redirect_to rules_path
  end

  def vote_up
    @rule = Rule.find(params[:id])

    if !current_user.voted_on?(@rule)
      current_user.vote_for(@rule)
      @rule.user.manpoints += 5
      @rule.user.save

      respond_to do |format|
        format.js
      end
    end
  end

  def vote_down
    @rule = Rule.find(params[:id])
    if !current_user.voted_on?(@rule)
      current_user.vote_against(@rule)
      @rule.user.manpoints -= 5
      @rule.user.save

      respond_to do |format|
        format.js
      end
    end
  end


  private

  def rule_params
    params.require(:rule).permit(:user, :manrule, :approved, :rejected, :rankpoints)
  end
end
