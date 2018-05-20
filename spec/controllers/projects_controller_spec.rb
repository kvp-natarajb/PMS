require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
	render_views
	login_admin
	let(:project) {create(:project, owner_id: subject.current_user.id)}
	
	it "should have a current_user" do
    	expect(subject.current_user).to_not eq(nil)
 	end

 	describe "GET #index" do
	    it "renders the index template" do
	      get :index
	      expect(response).to render_template("index")
	    end

	    it "responds successfully with an HTTP 200 status code" do
	      get :index
	      expect(response).to be_success
	      expect(response).to have_http_status(200)
	    end

	    it "loads all projects into the @projects" do
	      project = create(:project, owner_id: subject.current_user.id)
	      get :index
	      expect(assigns(:projects)).to match_array([project]) # not_to be_nil
	    end
	end

	describe "GET #new" do
	    it "assigns a blank project to the view" do
	      get :new
	      expect(assigns(:project)).to be_a_new(Project)
	    end
	end

	describe "POST #create" do
	    it "create a new project and add collaborators" do
	      developer1 = create(:user)
	      developer2 = create(:user)
	      emails = [developer1.email, developer2.email].join(',')
	      post :create, params: { project: attributes_for(:project, owner_id: subject.current_user.id, collaborator_emails: emails) }
	      expect(Project.count).to eq(1)
	      expect(response).to redirect_to(project_path(Project.last))
	    end

	    describe "with invalid attributes" do
		    it "does not save the new project" do
		      expect{
		        post :create, params: { project: attributes_for(:invalid_project) }
		      }.to_not change(Project, :count)
		    end
		end
	end

	describe "GET #show" do
	  it "should return project tasks" do
	  	task1 = project.tasks.create(attributes_for(:task, owner_id: subject.current_user.id))
	  	task2 = project.tasks.create(attributes_for(:task, owner_id: subject.current_user.id))
	  	expect(project.tasks).to match_array([task1, task2])
	  end
	  it "assigns the requested project to @project" do
	    get :show, params: { id:  project }
	    expect(assigns(:project)).to eq(project)
	  end
	  
	  it "renders the #show view" do
	    get :show, params: { id:  project }
	    expect(response).to render_template :show
	  end
	end

	describe "GET #update" do
		it "updates an project with valid params" do
			patch :update, params: { id: project, project: {name: "Updated Project"} }
  			project.reload
  			expect(project.name).to eq("Updated Project")
		end
	end

	describe 'DELETE #destroy' do
    
	  it "redirects to projects#index" do
	    delete :destroy, params: { id: project }
	    expect(response).to redirect_to projects_url
	  end
	end

end
