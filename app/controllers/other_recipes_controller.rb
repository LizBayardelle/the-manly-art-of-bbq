class OtherRecipesController < ApplicationController
  def beef
    @recipes = Recipe.where(beef: true, approved: true).plusminus_tally.order("plusminus_tally DESC")
  end

  def chicken
    @recipes = Recipe.where(chicken: true, approved: true).plusminus_tally.order("plusminus_tally DESC")
  end

  def fish
    @recipes = Recipe.where(fish: true, approved: true).plusminus_tally.order("plusminus_tally DESC")
  end

  def other_meat
    @recipes = Recipe.where(other_meat: true, approved: true).plusminus_tally.order("plusminus_tally DESC")
  end

  def veggies
    @recipes = Recipe.where(veggies: true, approved: true).plusminus_tally.order("plusminus_tally DESC")
  end

  def all
    @recipes = Recipe.plusminus_tally.order("plusminus_tally DESC")
    @unapproved_recipes = Recipe.where(approved: false, rejected: false)
  end
end
