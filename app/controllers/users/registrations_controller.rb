# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # POST /signup (ou /users)
  def create
    build_resource(sign_up_params)

    if resource.save
      render json: {
        status: { code: 200, message: 'Cadastro realizado com sucesso.' },
        data: UserSerializer.new(resource).to_h
      }
    else
      render json: {
        status: { message: "Não foi possível criar o usuário. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end