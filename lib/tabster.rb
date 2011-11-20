require 'tabster/configurable'
require 'tabster/version'
require 'tabster/helpers'

module Tabster
  include Tabster::Configurable
  include Tabster::Version

  SEPARATORS = %w( / )
  REQUIRED_TAB_FRAGMENTS = [:path_to]
  ALLOWED_PATH_FRAGMENTS = [:controller, :action]

  class << self
    delegate :config, :configure, :to => Tabster::Configurable

    def initialize
      raise "ActionController is not available yet." unless defined?(ActionController)
      ActionController::Base.send(:include, self)
      ActionController::Base.send(:helper, Tabster::Helpers)
    end

    def version
      Tabster::Version::STRING
    end
  end
end

if defined?(Rails::Railtie)
  require 'tabster/railtie'
else
  Tabster.send(:initialize)
end
