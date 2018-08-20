class PrinciplesController < ApplicationController

  def index
    render layout: 'application'
  end

  def intro
  end

  def intermediate
  end

  def advanced
  end

  def beef
    @suggestion = Suggestion.new
  end

  def steak
    @suggestion = Suggestion.new
  end

  def chicken
    @suggestion = Suggestion.new
  end

  def pork
    @suggestion = Suggestion.new
  end

  def fish
    @suggestion = Suggestion.new
  end

  def veggies
    @suggestion = Suggestion.new
  end

  def recipes
  end
end
