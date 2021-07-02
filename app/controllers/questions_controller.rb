class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :question_params, only: [:create]
  
  
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end
  
  def new 
    @question = Question.new
  end  
  
  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = '質問を投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '質問の投稿に失敗しました。'
      render :new
    end
  end  
  
  def edit
  end  

  
  def update
    if @question.update(question_params)
      flash[:success] = '質問を更新しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '質問が更新されませんでした'
      redirect_to :edit
    end  
  end  

  def destroy
    @question.destroy
    flash[:success] = '質問を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def search
    @questions = Question.search(params[:keyword])
    @keyword = params[:keyword]
    render :search
  end  
    
  private 
  
  def question_params
    params.require(:question).permit(:content)
  end  
  
  def correct_user
    @question =current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_back(fallback_location: root_path)
    end 
  end  
  
  def require_user_logged_in
    unless logged_in?
      redirect_to root_url
    end 
  end 
end
