require "rails/generators/base"

module Docks
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../template", __FILE__)
      desc "Installs the Docks initializer into your application"

      class_option :assets, type: :boolean,
                   aliases: "-a",
                   default: true,
                   desc: "Copy the default template's assets into your project."

      class_option :templates, type: :string,
                   aliases: "-t",
                   default: "erb",
                   desc: "Specify the language for the copied partials, views, and layouts (available: erb, haml, or slim)."

      class_option :scripts, type: :string,
                   aliases: "-s",
                   default: "javascript",
                   desc: "Specify the language for the copied script helpers (available: javascript or coffeescript)."

      def copy_views
        return unless options[:assets]
        copy_file "views/layouts/application.html.erb", "app/views/layouts/docks/application.html.erb"
        copy_file "views/layouts/demo.html.erb", "app/views/layouts/docks/demo.html.erb"

        copy_file "views/index.html.erb", "app/views/docks/home/index.html.erb"
        copy_file "views/pattern.html.erb", "app/views/docks/home/pattern.html.erb"
        copy_file "views/demo.html.erb", "app/views/docks/home/demo.html.erb"
      end

      # def copy_images
      #   return unless options[:assets]
      #   copy_file "images/icons.svg", "app/assets/images/docks/icons.svg"
      # end

      def copy_scripts
        return unless options[:assets]
      end

      def copy_config
        copy_file "config/rails/docks_config.rb", "config/initializers/docks.rb"
      end

      def display_readme
        readme "../POST_INSTALL" if behavior == :invoke
      end
    end
  end
end
