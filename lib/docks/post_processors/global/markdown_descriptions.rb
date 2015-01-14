module Docks
  module PostProcessors
    class MarkdownDescriptions < Base
      private

      class HTMLwithSyntaxHighlighting < Redcarpet::Render::HTML
        def block_code(code, language)
          return nil unless language
          "<fenced_code_block #{"data-has-demo='true'" unless (language =~ /demo/).nil?} data-language='#{language.sub(/_?demo/, "")}'>#{code}</fenced_code_block>"
        end

        def header(text, header_level)
          header_level = [header_level + 4, 6].min
          "<h#{header_level}>#{text}</h#{header_level}>"
        end
      end

      @@markdown = Redcarpet::Markdown.new(HTMLwithSyntaxHighlighting, fenced_code_blocks: true)

      public

      def self.post_process(parsed_file)
        parsed_file.each do |parse_result|
          parse_result.each do |key, value|
            parse_result[key] = if key == :description
              @@markdown.render(value.strip)
            else
              recursive_markdown_description(value)
            end
          end
        end

        parsed_file
      end

      private

      def self.recursive_markdown_description(item)
        if item.kind_of?(Hash)
          @@markdown.render(item[:description].strip) if item[:description].kind_of?(String)
        elsif item.kind_of?(Array)
          item.map! { |arr_item| self.recursive_markdown_description(arr_item) }
        end

        item
      end
    end
  end
end
