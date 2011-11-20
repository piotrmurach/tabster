if defined?(Rails::Railtie)
  module Tabster
    class Railtie < Rails::Railtie
      initializer :tabacious do
        Tabster.initialize
      end
    end
  end
end
