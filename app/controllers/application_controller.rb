class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
    
  def counts(user)
    @count_questions = user.questions.count
    @count_likes = user.likes.count
  end 
end
