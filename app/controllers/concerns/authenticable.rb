module Authenticable
  include ActiveSupport::Concern

  def current_user
    return @current_user if @current_user
    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)
    @current_user = User.find_by_email(decoded[:email]) rescue ActiveRecord::RecordNotFound
  end
end