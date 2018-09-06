module Superleggera
  class Engine < ::Rails::Engine
    initializer "superleggera.insert_middleware" do |app|
      app.config.middleware.use Superleggera::Middleware
    end
  end
end
