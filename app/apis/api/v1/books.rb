# -*- coding: UTF-8 -*-

module API
  module V1
    class Books < Grape::API
      resource :books do
        helpers do

          # Parameter check
          # :id
          params :id do
            requires :id, type: Integer, desc: "Book id."
          end

          # Parameter check
          # :attributes
          #   - :title
          #   - :author
          params :attributes do
            requires :title, type: String, desc: "Book title."
            requires :author, type: String, desc: "Book author."
          end
        end

        desc 'GET /api/v1/books'
        get '/', jbuilder: 'api/v1/books/index' do
          @books = Book.all
        end

        desc 'POST /api/v1/books'
        params do
          use :attributes
        end
        post '/' do
          book_params = ActionController::Parameters.new(params).permit(:title, :author)
          book = Book.new(book_params)
          book.save
        end

        desc 'GET /api/v1/books/:id'
        params do
          use :id
        end
        get '/:id', jbuilder: 'api/v1/books/show' do
          @book = Book.find(params[:id])
        end

        desc 'PUT /api/v1/books/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          book_params = ActionController::Parameters.new(params).permit(:title, :author)
          @book = Book.find(params[:id])
          @book.update(book_params)
        end
      end
    end
  end
end
