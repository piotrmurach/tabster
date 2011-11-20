module Tabster
  module Helpers
    #include CssTemplate

    # Use
    # <%= tabs_for :name do %>
    #    ...
    # <% end %>
    # or just <%= tabacious :name %>
    #
    def tabs_for(name, options = {}, &block)
      raise ArgumentError, "Missing name parameter in method call." unless name
      #raise ArgumentError, "Missing block in method call." unless block_given?

      #css_template_name = ::Utility::Config.configuration.css_template
      #unless css_template_name
        #concat render_css_template(css_template_name)
      #end
      puts "CONTROLLER: #{request.request_uri}"
      tabnav_name = name.to_s.parameterize.wrapped_string + '_tabnav'
      html =  content_tag(:div, render_tabnav_tabs(name), :id => "#{tabnav_name}_wrapper")
      puts "HTML RENDERING: #{html}"
      if block_given?
        html << content_tag(:div, capture(&block), :id => "#{tabnav_name}_content") 
        concat html
        nil
      end
      html
    end

    private

    def render_tabnav_tabs(tabnav_name)
      puts "CONFIGURATION : #{::Tabster.config.inspect}"
      tab_set = ::Tabster.config.tab_set
      return if tab_set.empty?

      list_items = []
      tab_set.each do |name, tab|
        li_options = {}
        li_options[:id] = "#{name.to_s.parameterize.wrapped_string}_container"
        #li_options[:class] = tab.highlighted?
        if tab.path
          active = request.request_uri =~ %r[#{tab.path}] ? 'active' : ''
          list_items << content_tag(:li, link_to("#{name.to_s.camelize}", tab.path, :class => active), li_options )
        else
          list_items << content_tag(:li, content_tag(:span, "#{name.to_s.camelize}"))
        end
      end
      content_tag(:ul, list_items, :id => "#{tabnav_name.to_s.parameterize.wrapped_string}_tabnav")
    end

    def config_cache
      return @config_cache if  @confige_cache
      @config_cache = ::Utility::Config.configuration
    end

  end
end
