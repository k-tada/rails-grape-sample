json.comments @comments do |comment|
  json.extract! comment, :id, :body, :updated_at
end
