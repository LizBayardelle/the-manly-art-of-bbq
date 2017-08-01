class HomeController < ApplicationController
  before_action :man_test

  def index
    @manliest_men = User.order("manpoints DESC").limit(5)
    @suggestion = Suggestion.new
    @man_test = ManTest.new
  end

  def parallax
  end

  def rules
  end

  def bbq
  end

  def jokes
  end

  def lifehacks
  end

  def gifthelper
  end

  def error
  end

  private

  def man_test
    unless user_signed_in? || ManTest.last.score == 1
      redirect_to controller: :man_tests, action: :new
    end
  end
end
