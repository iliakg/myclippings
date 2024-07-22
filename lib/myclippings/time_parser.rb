require 'time'

module Myclippings
  module TimeParser
    DAYS = %w[понедельник вторник среда четверг пятница суббота воскресенье].freeze
    MONTHS = %w[января февраля мара апреля мая июня июля августа сентября октября ноября декабря].freeze

    def time_parse(time_str)
      DAYS.each_with_index { |day, num| time_str.sub!(day, '') }
      MONTHS.each_with_index { |month, num| time_str.sub!(month, (num + 1).to_s) }
      time_str.sub!(', ', '')
      time_str.sub!(' г. в', '')
      Time.strptime(time_str, "%e %m %Y %T")
    end
  end
end
