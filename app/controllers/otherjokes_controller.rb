class OtherjokesController < ApplicationController
  def kids
    @jokes = Joke.where(joke_type: "Kids", approved: true).plusminus_tally.order("plusminus_tally DESC")
  end

  def mixed
    @jokes = Joke.where(joke_type: "Mixed", approved: true).plusminus_tally.order("plusminus_tally DESC")
  end

  def men
    @jokes = Joke.where(joke_type: "Men", approved: true).plusminus_tally.order("plusminus_tally DESC")
  end

  def comeback
    @jokes = Joke.where(joke_type: "Comeback", approved: true).plusminus_tally.order("plusminus_tally DESC")
  end
end
