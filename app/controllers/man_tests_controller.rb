class ManTestsController < ApplicationController
  layout false

  def new
    @man_test = ManTest.new
  end

  def create
    @man_test = ManTest.new(man_test_params)
    if @man_test.save && @man_test.score == 1
      if current_user
        current_user.manpoints += 1
        current_user.save
      end
      redirect_to home_index_path
      flash[:notice] = "Excellent. You're a man. We just have to check periodically."
    elsif @man_test.save && @man_test.score == 0
      if current_user
        current_user.manpoints -= 1
        current_user.save
      end
      redirect_to controller: :man_tests, action: :fail
    else
      render controller: :man_tests, action: :new
    end
  end

  def fail
  end

  private

  def man_test_params
    params.require(:man_test).permit(:user, :score)
  end
end
