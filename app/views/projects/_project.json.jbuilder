json.extract! project, :id, :name, :description, :start_date, :due_date, :status, :created_at, :updated_at
json.url project_url(project, format: :json)
