class ToppagesController < ApplicationController
  def index
    @questions =Question.all.order(id: :desc).page(params[:page])
  end
end
