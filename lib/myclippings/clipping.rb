require 'myclippings/time_parser'

module Myclippings
  class Clipping
    include TimeParser

    attr_reader :title,
                :author,
                :page,
                :time,
                :text,
                :filename

    FORBIDDEN_CHARACTERS_REGEX = /\/|\\|\:|\#|\^|\[|\]|\|/
    PAGE_KEYWORD = 'Ваш выделенный отрывок на странице'.freeze
    TIME_KEYWORD = 'Добавлено:'.freeze


    def initialize(lines)
      @lines = lines
      parse_title
      parse_page
      parse_time
      parse_text
      parse_filename
    end

    def parse_title
      regex = /^(.*) \((.*)\)\r?\n$/

      title, author = @lines[0].scan(regex).first

      if title.nil?
        title = @lines[0]
        author = ''
      end

      @title = sanitize_chars(title).strip
      @author = sanitize_chars(author).strip
    end

    def parse_page
      regex = /#{PAGE_KEYWORD} (\S+)/i
      @page = @lines[1][regex, 1]
    end

    def parse_time
      regex = /#{TIME_KEYWORD} (.*)\r?\n$/i
      @time = time_parse(@lines[1][regex, 1])
    end

    def parse_text
      @text = @lines[3..-2].join.strip
    end

    def parse_filename
      @filename = sanitize_chars(text[0..100]).strip
    end

    private

    def sanitize_chars(str)
      str.gsub(/[\u200B-\u200D\uFEFF]/, '').gsub(FORBIDDEN_CHARACTERS_REGEX, '_')
    end
  end
end
