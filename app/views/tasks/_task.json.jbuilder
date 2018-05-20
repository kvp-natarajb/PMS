json.extract! task, :id, :name, :description, :start_date, :due_date, :status, :project_id, :owner_id, :created_at, :updated_at
json.url task_url(task, format: :json)
