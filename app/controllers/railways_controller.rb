class RailwaysController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :set_railway, only: [:edit, :show]

  def index
    @railway = Railway.includes(:user).order("created_at DESC")
  end

  def new
    @railway = Railway.new
  end

  def create
    Railway.create(railway_params)
  end

  def destroy
    railway = Railway.find(params[:id])
    railway.destroy
  end

  def edit
  end

  def update
    railway = Railway.find(params[:id])
    railway.update(railway_params)
  end
  
  def show
    @comment = Comment.new
    @comments = @railway.comments.includes(:user)
  end

  def search
    @railways = Railway.search(params[:keyword])
  end

  private

  def railway_params
    params.require(:railway).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_railway
    @railway = Railway.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
