require "./strings_eng"

# Начальная строка последовательности Look and Say
FIRST_LINE = '1'

class String
  # Регулярное выражение для натурального числа
  NATURAL_NUMBER_REGEXP = /^[1-9]\d*$/

  # Регулярное выражение для нескольких подряд идущих одинаковых цифр
  SAME_DIGITS_REGEXP = /(.)\1*/

  # Индекс текущей цифры = 0, т.к. в худшем случае в подстроке из 1 элемента индекс будет только нулевой
  # Например при строке "21" метод с регулярным выражением вначале найдет подстроку current_same_digits = "2",
  # где current_same_digits[0] = '2'
  CURRENT_DIGIT = 0

  # Метод проверки натурального числа
  def is_natural_number?
    NATURAL_NUMBER_REGEXP === self
  end

  # Основной метод вычисления следующей строки последовательности Look and Say
  def look_and_say
    gsub(SAME_DIGITS_REGEXP){|current_same_digits| current_same_digits.size.to_s + current_same_digits[CURRENT_DIGIT]}
  end
end

# Пользователь может запустить программу сразу с заданным аргументом - числом строк вычисления последовательности Look and Say
lines_number = ARGV[0]

# Проверка что пользователь запустил программу без аргументов или указал некорректный аргумент
if lines_number.nil? or !lines_number.is_natural_number?
  argument_is_invalid = true

  # Программа запрашивает ввод числа пока пользователь не введет корректный аргумент
  while argument_is_invalid
    puts INVALID_ARGUMENT_MESSAGE  unless lines_number.nil?
    puts ENTER_NUMBER_MESSAGE
    user_input_number = $stdin.gets.chomp
    lines_number = user_input_number
    argument_is_invalid = false if user_input_number.is_natural_number?
  end
end

lines_number = lines_number.to_i

current_line = FIRST_LINE

# Вывод результирующей последовательности строк согласно заданному аргументу
puts RESULT_MESSAGE
lines_number.times {
  puts current_line
  current_line = current_line.look_and_say
}
