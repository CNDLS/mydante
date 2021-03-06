# from http://ruby.brian-schroeder.de/quiz/roman/browse/roman-rb.html

class Integer
  # Used for Integer to Roman conversion. (#roman)
  @@roman_values_assoc = %w(I IV V IX X XL L XC C CD D CM M).zip([1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000]).reverse

  # Used for Roman to Integer conversion. (Integer#roman)
  @@roman_values = @@roman_values_assoc.inject({}) { |h, (r,a)| h[r] = a; h }

  # Spits out the number as a roman number
  def roman
    return "-#{(-self).roman}" if self < 0
    return "" if self == 0
    @@roman_values_assoc.each do | (i, v) | return(i+(self-v).roman) if v <= self end
  end

  # Returns a roman number string
  def Integer.roman(roman)
    last = roman[-1,1]
    roman.reverse.split('').inject(0) { | result, c |
      if @@roman_values[c] < @@roman_values[last]
        result -= @@roman_values[c]
      else
        last = c
        result += @@roman_values[c]
      end
    }
  end
end

# The filter. Turns integers to roman numbers and roman numbers to integer. Everything else is left as it is.
#ARGF.each do | line |
#  puts case line
#       when /^(\d+)/:        Integer($1).roman
#       when /^([IVXLCDM]+)/: Integer.roman($1)
#       else line
#       end
#end