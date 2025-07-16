# app/models/user.rb

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  # Inclua este módulo para a estratégia de revogação
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :habits, dependent: :destroy

  # self.jwt_revocation_strategy = self # Esta linha é opcional se você usar o JTIMatcher
end