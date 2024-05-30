# frozen_string_literal: true

module Api
  module V1
    #
    # Handle read, write, update, and delete operation for content
    #
    class ContentsController < ApplicationController
      before_action :authenticate
      before_action :content, only: %i[update destroy]

      #
      # Endpoint to get list of contents
      # GET /content
      #
      # @return [Hash] {data: [{id, type, attribute: {title, body, createdAt, updatedAt}}, ...]}
      #
      def list
        render json: ContentSerializer.new(Content.all)
      end

      #
      # Endpoint to add content for authenticated user
      # POST /contents
      #
      # @return [Hash] {data: {id, type, attribute: {title, body, createdAt, updatedAt}}}
      #
      def create
        content = authenticated_user.contents
                                    .create!(content_params)

        render json: ContentSerializer.new(content), status: :created
      end

      #
      # Endpoint to add content for authenticated user
      # PUT /contents/:id
      #
      # @params [Integer] content_id
      #
      # @return [Hash] {data: {id, type, attribute: {title, body, createdAt, updatedAt}}}
      #
      def update
        @content.update!(content_params)

        render json: ContentSerializer.new(@content)
      end

      #
      # Endpoint to add content for authenticated user
      # DELETE /contents/:id
      #
      # @params [Integer] content_id
      #
      # @return [Hash] {message: "Deleted"}
      #
      def destroy
        @content.destroy!

        render json: {message: "Deleted"}
      end

      private

      #
      # Check if the request has authorization token and token is valid
      #
      def authenticate
        return if authenticated_user

        render json: {message: "Invalid token. Please re-login."}, status: :unauthorized
      end

      #
      # Allowed parameters for content endpoints
      #
      def content_params
        params.require(:content).permit(:title, :body)
      end

      #
      # Retrieve and authorize the content if it's owner is same as token user
      # NOTE: the authorization can be done with pundit/cancancan package for larger application
      #
      def content
        @content = authenticated_user.contents
                                     .find_by(id: params[:id])

        return if @content.present?

        render json: {message: "You are unauthorized"}
      end
    end
  end
end
