class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private 
  
  def counts(user)
    @counts_questions = user.questions.count
  end 
end
