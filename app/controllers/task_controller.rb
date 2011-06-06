class TaskController < ApplicationController
  before_filter :protect
  #protect_from_forgery :except => [:create,:delete,:update_star]
  def index
    @tasks = Task.find_all_by_user_id session[:user_id] ,:include => :user,:order =>"id DESC"
    #    if request.xhr?
    #      render :json => @tasks.to_json(
    #        :include => {:user => {:only=>[:id,:name,:lastname]}}
    #      )
    #    end
    @title = "Task"
  end

  def create
    if request.xhr?
      @task = Task.new() do |t|
        t.id = params[:task][:id]
        t.name = params[:task][:name]
        t.description = params[:task][:description]
        t.user_id = session[:user_id]
        t.star = false
        #t.priority = params[:priority]
        t.cr_date = DateTime.now().to_date
        #t.cr_date = DateTime.now()
      end
      @task.save

      @task.cr_date.to_formatted_s(:long)
      respond_to do |format|
        # format.html {redirect_to @task}
        format.js
      end
    end
  end
  
  def show
    @task = Task.find params[:id],
      :include => [:user],
      :order => "tasks.id DESC"
    @comment = Comment.new
    @title = "Task : "+@task.name #title in html page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @task = Task.find params[:task][:id]
    @task = Task.update(params[:task][:id],
      :name => params[:task][:name],
      :description => params[:task][:description])
    
    respond_to do |format|
      format.html {redirect_to @task}
      format.js
    end
  end

  def delete
    if request.xhr? && !params[:taskid].blank?
      if Task.destroy(params[:taskid])
        Comment.delete_all(["task_id=?",params[:taskid]])
        render :text => "true"
        return true
      end
    end
    render :text => "false"
    
  end

  def set_priority
  end

  def set_group
  end

  def update_star
    if !params[:id].blank?
      tasks = Task.find params[:id]
      tasks.star = !tasks.star
      tasks.save
    end
    render :text => :ok
  end
end
