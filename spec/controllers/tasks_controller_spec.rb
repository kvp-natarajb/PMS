require 'rails_helper'

RSpec.describe TasksController, type: :controller do
	render_views
	login_admin
	let(:project) {create(:project, owner_id: subject.current_user.id)}
	let(:task) {create(:task, owner_id: subject.current_user.id, project_id: project.id)}

	it "should have a current_user" do
    	expect(subject.current_user).to_not eq(nil)
 	end

	describe "GET #new" do
	    it "assigns a blank task to the view" do
	      get :new, params: { project_id: project.id }
	      expect(assigns(:task)).to be_a_new(Task)
	    end
	end

	describe "POST #create" do
	    it "create a new project related task" do
	      post :create, params: { task: attributes_for(:task), project_id: project.id }
	      expect(project.tasks.count).to eq(1)
	      expect(response).to redirect_to(project_path(project))
	    end
	end

	describe "GET #update" do
		it "updates an task status to done" do
			patch :update, params: { id: task.try(:id) , project_id: project.try(:id), task: { status: "done" } }
  			task.reload
  			expect(task.status).to eq("done")
		end

		it "updates an task status to in progress" do
			patch :update, params: { id: task.try(:id) , project_id: project.try(:id), task: { status: "in_progress" } }
  			task.reload
  			expect(task.status).to eq("in_progress")
		end
	end

end
