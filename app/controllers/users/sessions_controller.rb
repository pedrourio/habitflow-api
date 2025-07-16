# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    # A linha abaixo usa o Warden para tentar autenticar.
    # Se for sucesso, ele continua. Se falhar, ele aciona nossa CustomFailure app.
    warden.authenticate!(scope: :user)

    # Se a autenticação foi bem-sucedida, o `current_user` estará disponível.
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: UserSerializer.new(current_user).to_h
    }, status: :ok
  end

  # A ação de logout permanece a mesma, pois é gerenciada pelo frontend
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
end