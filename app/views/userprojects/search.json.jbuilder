json.array! @user do |user|
    json.user_id user[:user_id]
    json.email user[:email]
    json.description user[:description]
    json.assigned_by user[:assigned_by]
    json.project_id user[:project_id]
end
