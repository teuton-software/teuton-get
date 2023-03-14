require "colorize"

module TeutonGet
  class Format
    COLORS = [:light_blue, :light_magenta, :light_cyan, :red, :green, :yellow]
    @@disabled = false

    def self.disable
      @@disabled = true
      String.disable_colorization = true
    end

    def self.colorize(text = "", option = nil)
      return text if @@disabled || option.nil?
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

class MyColor
  COLORS = {
    black: 30, red: 31, green: 32, yellow: 33,
    blue: 34, violet: 35, cyan: 36, white: 37
  }

  def color(code)
    color = COLORS[code]
    if color.nil?
      color = COLORS[:violet]
      puts "[WARN] MyColor: unkown value color #{code}"
    end

    if code == :white
      "\e[%dm#{@text}\e[0m" % color
    else
      "\e[%d;1m#{@text}\e[0m" % color
    end
  end
end
