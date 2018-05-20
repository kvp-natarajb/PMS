class TasksController < ApplicationController

  layout "dashboard"
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project_users, only: [:new, :edit, :create, :update]

  def show;end

  def new
    @task = @project.tasks.new
  end

  def edit;end

  def create
    @task = @project.tasks.new(task_params.merge(owner_id: current_user.try(:id)))
    respond_to do |format|
      if @task.save
        params[:task][:assigned_user_ids] && params[:task][:assigned_user_ids].each do |user_id|
          @task.user_tasks.create(assigned_user_id: user_id)
        end
        format.html { redirect_to @project, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        @task.user_tasks.destroy_all
        params[:task][:assigned_user_ids] && params[:task][:assigned_user_ids].each do |user_id|
          @task.user_tasks.create(assigned_user_id: user_id)
        end
        format.html { redirect_to @project, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find_by_id(params[:project_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def set_project_users
      @project_users = []
      @project_users << @project.collaborators
      @project_users << current_user
      @project_users = @project_users.flatten
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description, :start_date, :due_date, :status, :project_id, :owner_id) #, assigned_user_ids: []
    end
end
