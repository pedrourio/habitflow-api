# lib/custom_failure.rb
class CustomFailure < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { error: 'É necessário fazer login ou se registrar antes de continuar.' }.to_json
  end
end