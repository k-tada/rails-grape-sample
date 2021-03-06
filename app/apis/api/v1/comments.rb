# -*- coding: UTF-8 -*-

module API
  module V1
    class Comments < Grape::API
      helpers do
        def set_book
          @book = Book.find(params[:book_id])
        end

        def set_comment
          @comment = Comment.find(params[:id])
        end

        def comment_params
          ActionController::Parameters.new(params).permit(:body)
        end

        # Parameter check
        # :book_id
        params :book_id do
          requires :book_id, type: Integer, desc: "Book id."
        end

        # Parameter check
        # :id
        params :id do
          requires :id, type: Integer, desc: "Comment id."
        end

        # Parameter check
        # :attributes
        #   - :body
        params :attributes do
          requires :body, type: String, desc: "Comment body."
        end
      end
      resource :books do
        # common params
        params do
          use :book_id
        end

        route_param :book_id do
          resource :comments do
            desc 'GET /api/v1/books/:book_id/comments'
            get '/', jbuilder: 'api/v1/comments/index' do
              set_book
              @comments = @book.comments
            end

            desc 'POST /api/v1/books/:book_id/comments'
            params do
              use :attributes
            end
            post '/' do
              set_book
              @book.comments.create(comment_params)
            end

            desc 'PUT /api/v1/books/:book_id/comments/:id'
            params do
              use :id
              use :attributes
            end
            put '/:id' do
              set_comment
              @comment.update(comment_params)
            end

            desc 'DELETE /api/v1/books/:book_id/comments/:id'
            params do
              use :id
            end
            delete '/:id' do
              set_comment
              @comment.destroy
            end
          end
        end
      end
    end
  end
end
