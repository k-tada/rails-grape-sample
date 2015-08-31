# -*- coding: UTF-8 -*-

module API
  module V1
    class Base < Grape::API
      # format setting
      format :json
      default_format :json
      formatter :json, Grape::Formatter::Jbuilder # for Grape:Jbuilder

      # path => /api/v1/path/to/api
      prefix :api
      version 'v1', using: :path

      #-----
      # Exception Handlers

      # 404
      rescue_from ActiveRecord::RecordNotFound do |e|
        rack_response({message: e.message, status: 404}.to_json, 404)
      end

      # 400
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response e.to_json, 400
      end

      # 500
      rescue_from :all do |e|
        if Rails.env.development?
          raise e
        else
          error_response(message: 'Internal Server Error', status: 500)
        end
      end


    end
  end
end
