class Api::V1::RandomUsersDataController < ApplicationController
  before_action :check_user, only: %i[show]

  def show
    data = CacheUsersReader.call
    render json: data, status: 200
  end


  private

  def check_user
    head :unauthorized if current_user.nil?
  end

end
