class ProjectsController < ApplicationController

  layout "dashboard"

  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # before_action :set_my_projects, only: [:index, :show, :new]

  def index
    @projects = current_user.active_projects + current_user.collaboration_projects.active
    @projects = @projects.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @tasks = @project.tasks.order('created_at')
  end

  def new
    @project = current_user.projects.new
  end

  def edit;end

  def create
    @project = Project.new(project_params.merge(owner_id: current_user.id))
    respond_to do |format|
      if @project.save
        add_collaborators(project_params[:collaborator_emails])
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        add_collaborators(project_params[:collaborator_emails])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def set_my_projects
      @my_projects = current_user.projects
    end

    def project_params
      params.require(:project).permit(:name, :description, :collaborator_emails, :start_date, :due_date, :status, :owner_id)
    end

    def add_collaborators(emails)
      if emails.present?
        email_array = emails.split(',').map(&:strip)
        email_array.each do |email|
          user = User.find_by(email: email)
          unless user.nil? || user == @project.owner || @project.collaborators.include?(user)
            @project.collaborators << user
            @project.save
          end
        end
      end
    end
end
