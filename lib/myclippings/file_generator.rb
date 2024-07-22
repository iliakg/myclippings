require 'erb'

module Myclippings
  class FileGenerator
    TEMPLATE_PATH = File.dirname(__FILE__) + '/../../templates/quote.erb'
    OUTPUT_DIR = File.dirname(__FILE__) + '/../../results/'

    attr_reader :clippings

    def initialize(clippings)
      @clippings = clippings
    end

    def run
      clippings.each do |clipping|
        @clipping = clipping
        File.open("#{OUTPUT_DIR}#{@clipping.filename}.md", 'w') { |f| f.write(result) }
      end
    end

    private

    def template
      File.read(TEMPLATE_PATH)
    end

    def result
      ERB.new(template).result(binding)
    end
  end
end
