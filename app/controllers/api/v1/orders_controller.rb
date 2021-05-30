# frozen_string_literal: true

class Api::V1::OrdersController < ApplicationController
  def create
    if order_params.blank?
      render status: :not_found
    end

    result = Operations::Order::Create.new.call(order_params)

    if result.present?
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.permit!
  end
end
