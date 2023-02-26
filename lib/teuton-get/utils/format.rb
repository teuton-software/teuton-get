require "colorize"

module TeutonGet
  module Format
    COLORS = [:light_blue, :light_magenta, :light_cyan, :red, :green, :yellow]

    def self.disable
      String.disable_colorization = true 
    end

    def self.colorize(text = "", option = nil)
      return text if option.nil?
      color = if option.instance_of? Integer
        if option < COLORS.size
          COLORS[option]
        else
          COLORS[option - COLOR.size]
        end
      elsif option.instance_of? Symbol
        option
      else
        :silver
      end
      text.colorize(color)
    end
  end
end
