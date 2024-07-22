module Myclippings
  class Parser
    attr_reader :path, :clippings

    END_CLIP = /^==========\r?\n$/

    def initialize(path)
      @path = path
      @clippings = []
    end

    def parse
      lines = []
      File.open(path).each do |line|
        lines << line
        if last_record?(lines)
          clippings << parse_clipping(lines)
          lines.clear
        end
      end

      # Remove empty clippings
      clippings.delete_if { |clipping| clipping.text.empty? }

      clippings
    end

    def last_record?(lines)
      lines.last =~ END_CLIP
    end

    def parse_clipping(lines)
      Clipping.new(lines)
    end
  end
end
