# -*- coding: UTF-8 -*-

module API
  module V1
    class Books < Grape::API
      resource :books do
        desc 'GET /api/v1/books'
        get '/', jbuilder: 'api/v1/books/index' do
          @books = Book.all
        end

        desc 'POST /api/v1/books'
        params do
          requires :title, type: String, desc: "Book title."
          requires :author, type: String, desc: "Book author."
        end
        post '/' do
          book_params = ActionController::Parameters.new(params).permit(:title, :author)
          book = Book.new(book_params)
          book.save
        end
      end
    end
  end
end
