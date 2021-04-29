# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError do |error|
    render status: :not_found
  end
end
