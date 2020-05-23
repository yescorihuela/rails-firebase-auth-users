module Authenticable
  include ActiveSupport::Concern

  def current_user
    return @current_user if @current_user
    header = request.headers['Authorization']
    return nil if (header.nil? or header.strip == '')

    decoded = ::FirebaseIdToken::Signature.verify(header)
    @current_user = User.find_by_email(decoded["email"]) rescue ActiveRecord::RecordNotFound
  end
end