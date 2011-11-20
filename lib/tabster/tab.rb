module Tabster
  class Tab
    attr_accessor :path
    attr_accessor :name
    attr_accessor :tabs

    attr_accessor_with_default :priority,   1
    attr_accessor_with_default :title,      'default'
    attr_accessor_with_default :sub_tabnav, []

    def initialize(options = {}, &block)
      puts " SEGMENTS IN TAB: #{options.inspect}"

      if block_given?
        @tabs = TabSet.new
        puts "BLOCK: #{block.inspect}"
        yield @tabs
      end

      @path      = options[:path_to] || '/'
      @highlight = options[:highlights_on] || ''
      @priority  = options[:priority] || 1
    end

    def add_tab(name, options, &block)
      Tabnav.new.add_tab(name, options, &block)
    end

    def extract_tabs(collection = [])
      return nil unless collection.is_a? Array
      collection.map { |item| self.new( { :title => item.title, :path => item.path }) }
    end

    def freeze
      self
    end
  end #Tab
end #Tabster
