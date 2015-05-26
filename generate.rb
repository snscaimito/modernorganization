require "jekyll-import"


module JekyllImport
  module Importers
    class CaimitoRSS < Importer
      def self.specify_options(c)
        c.option 'source', '--source NAME', 'The RSS file or URL to import'
      end

      def self.validate(options)
        if options['source'].nil?
          abort "Missing mandatory option --source."
        end
      end

      def self.require_deps
        JekyllImport.require_with_fallback(%w[
          rss/1.0
          rss/2.0
          open-uri
          fileutils
          safe_yaml
        ])
      end

      # Process the import.
      #
      # source - a URL or a local file String.
      #
      # Returns nothing.
      def self.process(options)
        source = options.fetch('source')

        content = ""
        open(source) { |s| content = s.read }
        rss = ::RSS::Parser.parse(content, false)
        
        raise "There doesn't appear to be any RSS items at the source (#{source}) provided." unless rss

        rss.items.each do |item|
          formatted_date = item.date.strftime('%Y-%m-%d')
          post_name = item.title.split(%r{ |!|/|:|&|-|$|,}).map do |i|
            i.downcase if i != ''
          end.compact.join('-')
          name = "#{formatted_date}-#{post_name}"

          language = rss.channel.language
          language = language.slice(0..(language.index('-')) - 1)

          header = {
            'layout' => 'post',
            'title' => item.title,
            'source_url' => item.link,
            'author' => item.author,
            'language' => language,
            'gravatar' => 'https://www.gravatar.com/' + Digest::MD5.hexdigest(item.author)
          }

          FileUtils.mkdir_p("_posts")

          File.open("_posts/#{name}.html", "w") do |f|
            f.puts header.to_yaml
            f.puts "---\n\n"
            f.puts item.description
          end
        end
      end
    end
  end
end


JekyllImport::Importers::CaimitoRSS.run({
  "source" => "http://www.stephan-schwab.com/agile-en.xml"
})
