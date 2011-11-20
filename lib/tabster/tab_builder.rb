#TODO make use of the passed block to create subitems in the navigation.

module Tabster
  class TabBuilder

    # Construct and return a tab with the given path and options.
    def build(options, &block)
      segments = extract_tab_segments(options)
      puts "EXTRACTED FRAGMENTS: #{segments.inspect}"
      tab = Tab.new(segments, &block)
      tab.freeze
    end

    def extract_tab_segments(options)
      segments = {}
      options.each do |key, value|
        if [:path_to].include?(key)
          segments[key] = extract_path_segment(value)
        elsif [:priority].include?(key)
          segments[key] = value.to_i
        elsif [:highlights_on].include?(key)
          if value.is_a? Proc
            segments[key] = value
          end
        end
      end
      segments
    end

    def extract_path_segment(path_to)
      case path_to.class.to_s
        when 'String'
          normalize_path(wrap_path_with_slashes(path_to.to_s))
        when 'Symbol'
          normalize_path(wrap_path_with_slashes(path_to.to_s))
        when 'Hash'
          # if controller key given, make action an explicit param
          action = path_to[:action].nil? ? 'index' : path_to[:action]
          if path_to[:controller] 
            normalize_path("#{path_to[:controller]}/#{action}")
          else
            raise ArgumentError, ":path_to is invalid in tab parameters. Need to specify at least the controller, i.e. :controller => :admin"
          end
      end
    end

    def wrap_path_with_slashes(path)
      path = "/#{path}" unless path[0] == ?/
      path = "#{path}/" unless path[-1] == ?/
    end

    # Returns a path cleaned of double-shlashes and relative path references.
    def normalize_path(path)
      path = path.
        gsub("//", "/"). 
        gsub("\\\\", "\\").
        gsub(%r{(.)[\\/]$}, '\1')

      re = %r{[^/\\]+[/\\]\.\.[/\\]}
      path.gsub!(re, "") while path.match(re)
      path
    end

  end # TabBuilder
end # Tabster
