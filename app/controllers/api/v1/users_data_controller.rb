class Api::V1::UsersDataController < ApplicationController
  def show
    data = CacheUsersReader.call
    render json: data, status: 200
  end
end
