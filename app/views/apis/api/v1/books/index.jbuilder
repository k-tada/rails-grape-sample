json.books @books do |book|
  json.extract! book, :id, :title, :author, :updated_at
end
