json.extract! project, :id, :user_id, :subject, :description, :start_at, :end_at, :created_at, :updated_at
json.url project_url(project, format: :json)