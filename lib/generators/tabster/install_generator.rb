module Tabster
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Tabster initializer and copies css styles to your application"

      def copy_initializer
        template 'tabster.rb', 'config/initializers/tabster.rb'
      end

      def copy_stylesheet
        copy_file "tabster.css", File.join('app/assets/stylesheets', "#{file_name}.css")
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end # Tabster
