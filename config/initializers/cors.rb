# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Permite que o seu frontend React (em localhost:5173) faça requisições
    origins "http://localhost:5173"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      # IMPORTANTE: Expor o header 'Authorization' para que o frontend possa lê-lo
      expose: ['Authorization']
  end
end