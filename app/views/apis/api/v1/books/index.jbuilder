json.books @books do |book|
  json.partial! 'api/v1/books/book', book: book

  json.comments book.comments do |comment|
    json.partial! 'api/v1/comments/comment', comment: comment
  end

  json.comment_count book.comments.count
end
