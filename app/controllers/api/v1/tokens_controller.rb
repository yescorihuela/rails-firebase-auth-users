class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    if @user&.authenticate(user_params[:password])
      render json: {
        token: JsonWebToken.encode(email: @user.email),
        user_id: @user.id
      }, status: :ok
    else
      head :unauthorized
    end
  end

  private

  def user_params
    puts params.to_json
    params.require(:user).permit(:email, :password)
  end

end
