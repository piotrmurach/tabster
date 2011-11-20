require 'active_support'

module Tabster
  class TabSet
    include Enumerable
    include ActiveSupport

    attr_reader :tabs
    attr_reader :name

    def initialize
      clear!
    end

    def add(name, options = {}, &block)
      add_tab(name, options, &block)   
    end

    def add_tab(name, options = {}, &block)
      puts "ADDING TAB: #{options.inspect}"
      raise_tab_name_error if name.nil?
      options = options.dup.symbolize_keys 
      options.assert_valid_keys(:path_to, :highlights_on, :priority)
      ensure_required_fragments(options)
      tab = builder.build(options, &block)
      @tabs[name.to_sym] = tab
      tab
    end

    def ensure_required_fragments(options)
      Tabster::REQUIRED_TAB_FRAGMENTS.each do |fragment|
        unless options.has_key? fragment.to_sym
          raise ArgumentError, "Tab fragment :path_to cannot be optional."
        end
      end
    end

    def builder
      @builder ||= TabBuilder.new
    end

    def method_missing(tab_name, *args, &proc)
      super
    end

    def get(name)
      @tabs[name.to_sym]
    end

    def clear!
      @tabs = ActiveSupport::OrderedHash.new
    end

    def tab_names
      @tabs.keys
    end

    def each
      tabs.each { |name, params| yield name, params }
      self
    end

    def names
      tabs.keys
    end

    def sort!(sort_key = :priority, &block)
      sort_key = sort_key.to_sym
      if block_given?
        tabs.sort &block
      else
        tabs.sort { |tab1, tab2| tab1[1][sort_key] <=> tab2[1][sort_key] }
      end
    end

    def empty?
      tabs.empty?
    end

    def length
      tabs.length
    end

    def raise_tab_name_error
      raise TabRoutingError, "Failed to generate tab from params."  
    end

    class TabRoutingError < StandardError; end
    class TabWrongParams < StandardError; end

    alias []= add_tab
    alias []  get
    #alias clear clear!

  end # TabSet
end # Tabster
