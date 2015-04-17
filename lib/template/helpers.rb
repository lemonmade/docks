module DocksHelpers
  def relative_asset_path(asset)
    (Docks.config.destination + asset).relative_path_from(Docks.current_template)
  end

  def stylesheet_link_tag(stylesheet)
    "<link rel='stylesheet' type='text/css' href='#{relative_asset_path File.join("styles", "#{stylesheet.split(".").first}.css")}'>"
  end

  def javascript_include_tag(script)
    "<script src='#{relative_asset_path File.join("scripts", "#{script.split(".").first}.js")}'></script>"
  end



  def docks_icon(name, options = {})
    klass = "icon"

    size = options.delete(:size)
    klass << " icon--#{size}" unless size.nil?

    color = options.delete(:color)
    klass << " icon--#{color}" unless color.nil?

    "<svg class='#{klass}'><use xlink:href='#icon--#{name}'></svg>"
  end

  def docks_component(name, opts = {}, &block)
    render(File.expand_path("../templates/components/#{name}"), component: Component.new(opts, &block))
  end

  [
    :avatar,
    :select,
    :code_block,
    :button,
    :demo,
    :tablist,
    :tablist_tab,
    :tablist_panel,
    :table,
    :resizable,
    :toggle,
    :toggle_container,
    :details_sheet,
    :exploded,
    :popover,
    :xray

  ].each do |component_name|
    define_method "docks_#{component_name}".to_sym do |opts = {}, &block|
      docks_component(component_name, opts, &block)
    end
  end

  class Component
    attr_reader :_classes
    attr_accessor :_attributes

    def self.standardize_classes(classes, base_component = :base)
      return {} if classes.nil?

      if classes.kind_of?(Hash)
        classes.each do |key, klass|
          classes[key] = klass.kind_of?(String) ? klass.split(" ") : klass
        end
      else
        classes = classes.kind_of?(String) ? classes.split(" ") : classes
        class_hash = {}
        class_hash[base_component] = classes

        classes = class_hash
      end

      classes
    end

    def initialize(opts = {}, &block)
      @_classes = Component.standardize_classes(opts.delete(:classes))
      @_attributes = opts
      @_block = block
    end

    def block
      @_block
    end

    def config
      yield Config.new(self)
    end

    def method_missing(meth, *args)
      @_attributes[meth]
    end

    def classes_for(subcomponent = :base)
      @_classes[subcomponent].join(" ")
    end

    def to_s
      @_attributes
    end

    private

    class Config
      def initialize(component)
        @component = component
      end

      def defaults(opts = {})
        @component._attributes.reverse_merge!(opts)
      end

      def classes(default_classes = {})
        default_classes = Component.standardize_classes(default_classes)
        @component._classes.merge!(default_classes) do |key, passed, default|
          passed.concat(default).uniq
        end
      end

      def conditional_classes(opts)
        if (attribute = opts.delete(:if))
          classes(opts) if @component.send(attribute).present?
        elsif (attribute = opts.delete(:unless))
          classes(opts) if @component.send(attribute).blank?
        elsif (attribute = opts.delete(:with))
          return unless block_given?
          classes(yield @component.send(attribute))
        elsif (attribute = opts.delete(:from))
          classes(opts[@component.send(attribute)])
        end
      end
    end
  end
end
