class CommentController < ApplicationController
 before_filter :protect
  def index
    @comments = Comment.find_all_by_task_id params[:id],:include => :user,:order => "id DESC"
    render  :json => @comments.to_json(
      :include => {:user => {:only=>[:id,:name,:lastname]}}
    )
    
  end

  def show
  end

  def create 
      @comment = Comment.create!(){ |t|
        t.comment = params[:comment][:comment]
        t.user_id = session[:user_id]
        t.task_id = params[:comment][:task_id]
        t.created_at = DateTime.now()
        t.updated_at = DateTime.now()
      }
      respond_to do |format|
        format.html {redirect_to @comment.show}
        format.js
      end
  end
  
  def delete
  end

end
