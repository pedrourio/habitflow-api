class UserSerializer
  def initialize(user)
    @user = user
  end

  def to_h
    { id: @user.id, email: @user.email, name: @user.name }
  end
end