# -*- coding: UTF-8 -*-

module API
  module V1
    class Books < Grape::API
      resource :books do
        desc 'GET /api/v1/books'
        get '/', jbuilder: 'api/v1/books/index' do
          @books = Book.all
        end
      end
    end
  end
end
