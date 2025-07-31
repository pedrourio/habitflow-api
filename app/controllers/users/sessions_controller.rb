# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    warden.authenticate!(scope: :user)
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: UserSerializer.new(current_user).to_h
    }, status: :ok
  end

  # e a revogação do token é feita pelo middleware do devise-jwt.
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end