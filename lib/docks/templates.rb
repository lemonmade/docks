module Docks
  module Templates
    class Template
      attr_reader :path, :layout

      def initialize(name, options = {})
        @path = name
        @matcher = options[:matches] || options[:for]
        @layout = options[:layout]
      end

      def layout
        @layout.nil? ? Templates.default_layout : @layout
      end

      def matches?(id)
        !(@matcher =~ id).nil?
      end
    end

    def self.demo_template; @@demo_template end
    def self.default_layout; @@default_layout end
    def self.fallback_template; @@fallback_template end
    def self.default_template; fallback_template end

    def self.fallback_template=(template); @@fallback_template = Template.new(template) end
    def self.default_template=(template); self.fallback_template = template end
    def self.default_layout=(layout); @@default_layout = layout end

    def self.demo_template=(template); self.set_demo_template(template) end

    def self.set_demo_template(template, options = {})
      options[:layout] ||= "demo"
      @@demo_template = Template.new(template, options)
    end

    def self.register(template, options = {})
      @@templates << Template.new(template, options)
    end

    def self.template_for(id)
      id = id.name if id.kind_of?(Containers::Pattern)
      return demo_template if id.to_sym == :demo_template

      @@templates.reverse_each do |template|
        return template if template.matches?(id)
      end

      fallback_template
    end

    def self.search_for_template(template, options = {})
      return template if File.exists?(template)

      if options[:must_be].nil?
        in_root = loose_search_for(template)
        return in_root unless in_root.nil?
      end

      in_specific = loose_search_for(File.join("#{(options[:must_be] || :partial).to_s.sub(/s$/, '')}{s,}", template))
      return in_specific unless in_specific.nil?
    end

    private

    def self.loose_search_for(path)
      return if path.nil?
      path = Docks.config.library_assets + Docks.config.asset_folders.templates + path
      path_pieces = path.to_s.sub(File.extname(path), "").split("/")
      path_pieces[path_pieces.length - 1] = "{_,}#{path_pieces.last}"
      Dir.glob("#{path_pieces.join("/")}.*").first
    end

    def self.clean
      @@demo_template = Template.new("demo", layout: "demo")
      @@fallback_template = Template.new("pattern")
      @@default_layout = "application"
      @@templates = []
    end

    clean
  end

  def self.template_for(id); Templates.template_for(id) end
  def self.current_render_destination; @current_render_destination end
  def self.current_render_destination=(destination); @current_render_destination = destination end
  def self.component_template_path; Pathname.new(File.expand_path("../../template/assets/templates/components", __FILE__)) end
end
