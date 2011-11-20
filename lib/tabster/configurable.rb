module Tabster
  module Configurable

    # Holds all the parameters for the Tabster initializer and defaults
    # that should suite most needs. It's possible to overwrite those as well.
    # This class is passed through the block running on the Tabster module.
    class Configuration

      attr_accessor_with_default :name,         :main
      attr_accessor_with_default :css_template, :main
      attr_accessor_with_default :helpers,      []
      attr_accessor_with_default :includes,     []
      attr_accessor :tab_set

      def initialize
       initialize_tab_set!
      end

      def initialize_tab_set!
        @tab_set = TabSet.new
      end

      # Reload the tab ordering
      def reload
        @tab_set = tab_set.nil? ? nil : tab_set
      end

      # add class methods to return tabnavs
      #self.class_eval 
      #  define_method
      #end

      def draw
        yield @tab_set
        @tab_set
      end

      def validate!
        raise ConfigurationError.new("Tab navigation needs name as a String or Symbol \n e.i. config.name = :admin") unless self.name.is_a? String or self.name.is_a? Symbol
      end

      def configuration_path
        "#{RAILS_ROOT}/config/initializers/tabacious.rb"
      end

      class ConfigurationError < StandardError; end

    end # Configuration

    class << self

      attr_reader :config

      def config
        @@config ||= Configuration.new
      end

      def configure(&block)
        raise "configure must be sent a block" unless block_given?
        yield config
        config.validate!
      end

      def to_hash
        { :name => @@config.name, :css_template => @@config.css_template}
      end

    end

  end # Configurable
end # Tabster
