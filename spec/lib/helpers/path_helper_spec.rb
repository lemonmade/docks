require "spec_helper"

describe Docks::Helpers::Path do
  subject do
    Class.new { include Docks::Helpers::Path }.new
  end

  let(:pattern_library) { Docks::Containers::PatternLibrary.new }
  let(:pattern) { Docks::Containers::Pattern.new(name: "foo") }

  before(:each) do
    Docks::Languages.register_bundled_languages
    Docks.current_render_destination = Docks.config.destination + "baz/index.html"
    subject.instance_variable_set(:@pattern_library, pattern_library)
    subject.instance_variable_set(:@pattern, pattern)
  end

  describe "#docks_path" do
    it "returns the anchor for a search that is found in the pattern" do
      result = Docks::Containers::Symbol.new(name: "foo")
      expect(pattern).to receive(:find).with("foo").and_return result
      expect(subject.docks_path("foo")).to eq "##{result.symbol_id}"
    end

    it "returns the anchor for a search that is found in the pattern library" do
      result = Docks::Containers::Symbol.new(name: "foo")
      expect(pattern_library).to receive(:find).with("bar").and_return OpenStruct.new(pattern: pattern, symbol: result)
      expect(subject.docks_path("bar")).to eq "#{subject.relative_asset_path(subject.pattern_path(pattern))}##{result.symbol_id}"
    end

    it "returns a path from the registered symbol sources if one exists" do
      expect(subject.docks_path("Object")).to eq Docks::SymbolSources.path_for("Object")
    end

    context "when there are multiple requests for the same thing" do
      it "caches the result of the same path request" do
        expected = Docks::SymbolSources.path_for("Object")
        expect(Docks::SymbolSources).to receive(:path_for).with("Object", anything).once.and_call_original
        subject.docks_path("Object")
        subject.docks_path("Object")

        result = Docks::Containers::Symbol.new(name: "foo")
        expect(pattern).to receive(:find).with("foo").once.and_return result
        subject.docks_path("foo")
        subject.docks_path("foo")
      end

      it "caches the results of requests that have different language options" do
        sass_expected = Docks::SymbolSources.path_for("Map", language: :sass)
        js_expected = Docks::SymbolSources.path_for("Map", language: :js)

        expect(Docks::SymbolSources).to receive(:path_for).with("Map", language: :sass).once.and_call_original
        expect(Docks::SymbolSources).to receive(:path_for).with("Map", language: :js).once.and_call_original

        subject.docks_path("Map", language: :sass)
        subject.docks_path("Map", language: :js)
        subject.docks_path("Map", language: :sass)
        subject.docks_path("Map", language: :js)
      end
    end
  end

  describe "#stylesheet_link_tag" do
    let(:expected_path) { subject.relative_asset_path(Docks.config.destination + "styles/style.css").to_s }

    it "returns a relative path to the stylesheet" do
      output = subject.stylesheet_link_tag("style")
      expect(output).to have_tag :link, with: { rel: "stylesheet", type: "text/css", href: expected_path }
    end

    it "doesn't duplicate the filename" do
      output = subject.stylesheet_link_tag("style.css")
      expect(output).to have_tag :link, with: { href: expected_path }
    end

    it "handles fully formed paths" do
      output = subject.stylesheet_link_tag(Docks.config.destination + "styles/style.css")
      expect(output).to have_tag :link, with: { rel: "stylesheet", type: "text/css", href: expected_path }
    end
  end

  describe "#javascript_include_tag" do
    let(:expected_path) { subject.relative_asset_path(Docks.config.destination + "scripts/script.js").to_s }

    it "returns a relative path to the script" do
      output = subject.javascript_include_tag("script")
      expect(output).to have_tag :script, with: { src: expected_path }
    end

    it "doesn't duplicate the filename" do
      output = subject.javascript_include_tag("script.js")
      expect(output).to have_tag :script, with: { src: expected_path }
    end

    it "handles fully formed paths" do
      output = subject.javascript_include_tag(Docks.config.destination + "scripts/script.js")
      expect(output).to have_tag :script, with: { src: expected_path }
    end
  end

  describe "#relative_asset_path" do
    it "returns a path relative to the current render destination" do
      expect(subject.relative_asset_path(Docks.current_render_destination)).to eq Pathname.new(".")
      expect(subject.relative_asset_path(Docks.current_render_destination + "foo/bar.baz")).to eq Pathname.new("foo/bar.baz")
      expect(subject.relative_asset_path(Docks.current_render_destination.dirname)).to eq Pathname.new("..")
    end
  end

  describe "#compiled_style_tags" do
    let(:css_path) { Pathname.new(Docks.config.root + "foo.css") }
    let(:css_filename) { css_path.basename.to_s }

    it "returns nothing when the compiled assets are empty" do
      expect(subject.compiled_style_tags).to be nil

      Docks.configure_with(compiled_assets: [])
      expect(subject.compiled_style_tags).to be nil

      Docks.configure_with(compiled_assets: nil)
      expect(subject.compiled_style_tags).to be nil
    end

    it "includes CSS assets" do
      Docks.configure_with(compiled_assets: [css_filename, "bar.scss", "baz.js"])

      expect(File).to receive(:exists?).with(css_path).and_return true
      expect(subject).to receive(:stylesheet_link_tag).with(css_path).and_return css_filename

      expect(subject).not_to receive(:stylesheet_link_tag).with("bar.scss")
      expect(subject).not_to receive(:stylesheet_link_tag).with("baz.js")

      expect(subject.compiled_style_tags).to eq css_filename
    end

    it "does not include CSS assets that don't exist" do
      Docks.configure_with(compiled_assets: css_filename)

      expect(File).to receive(:exists?).with(css_path).and_return false
      expect(subject).to_not receive(:stylesheet_link_tag).with "foo.css"

      expect(subject.compiled_style_tags).to be nil
    end
  end

  describe "#compiled_script_tags" do
    let(:js_path) { Pathname.new(Docks.config.root + "foo.js") }
    let(:js_filename) { js_path.basename.to_s }

    it "returns nothing when the compiled assets are empty" do
      expect(subject.compiled_script_tags).to be nil

      Docks.configure_with(compiled_assets: [])
      expect(subject.compiled_script_tags).to be nil

      Docks.configure_with(compiled_assets: nil)
      expect(subject.compiled_script_tags).to be nil
    end

    it "includes CSS assets" do
      Docks.configure_with(compiled_assets: [js_filename, "bar.coffee", "baz.css"])

      expect(File).to receive(:exists?).with(js_path).and_return true
      expect(subject).to receive(:javascript_include_tag).with(js_path).and_return js_filename

      expect(subject).not_to receive(:javascript_include_tag).with("bar.scss")
      expect(subject).not_to receive(:javascript_include_tag).with("baz.js")

      expect(subject.compiled_script_tags).to eq js_filename
    end

    it "does not include CSS assets that don't exist" do
      Docks.configure_with(compiled_assets: js_filename)

      expect(File).to receive(:exists?).with(js_path).and_return false
      expect(subject).to_not receive(:javascript_include_tag).with "foo.css"

      expect(subject.compiled_script_tags).to be nil
    end
  end
end

