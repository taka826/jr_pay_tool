class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/railways/#{comment.railway.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, railway_id: params[:railway_id])
  end
end
