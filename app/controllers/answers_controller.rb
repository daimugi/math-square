class AnswersController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  before_action :answer_params, only: [:create]
  
  def show
    @answer = current_user.answers.find_by(id: params[:id])
    @question = @answer.question
    unless @answer
    redirect_back(fallback_location: root_path)
    end
  end

  def new
    @question = Question.find_by(id: params[:question_id])
    @answer = @question.answers.build
  end

  def create
    @answer = current_user.answers.build(answer_params)
    @question = @answer.question
    if @answer.save
      flash[:success] = '回答しました'
      redirect_to question_path(@answer.question)
    else 
      flash.now[:danger] = '回答できませんでした'
      render :new
    end  
  end

  def destroy
    @answer =current_user.answers.find_by(id: params[:id])
    @answer.destroy
    flash[:success] ='回答を削除しました'
    redirect_to question_path(@answer.question)
  end
  
  private
  
  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end  
  
  def require_user_logged_in
    unless logged_in?
      redirect_to root_url
    end 
  end 
end
