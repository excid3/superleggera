require "superleggera/engine"

module Superleggera
  class Error < StandardError; end

  class Middleware
    def initialize app
      @app = app
    end

    def call env
      @status, @headers, @response = @app.call(env)

      merge_whitelist

      [@status, @headers, @response]
    end

    def merge_whitelist
      classes = load_whitelist
      classes += parse_classes(@response)
      classes.uniq!
      classes.sort!
      write_whitelist(classes)
    end

    def parse_classes(document)
      matches = document.scan(/class=["'](.+)["']/)
      matches.flatten.flat_map(&:split)
    end

    def write_whitelist(classes)
      File.open(whitelist_path, "w") do |f|
        f.write(classes.to_json)
      end
    end

    def load_whitelist
      if File.exist?(whitelist_path)
        JSON.load File.open(whitelist_path)
      else
        []
      end
    rescue JSON::ParserError
      raise Error, "Unable to parse #{whitelist_path}. The contents should be a valid JSON array of class names."
    end

    def whitelist_path
      File.join(Engine.root, "config/whitelist.json")
    end
  end
end
