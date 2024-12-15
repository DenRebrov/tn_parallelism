# Генерация файлов для примера
files = 5.times.map do |i|
  filename = "file_#{i}.txt"
  File.open(filename, 'w') { |f| f.puts(Array.new(100_000) { "Line from #{filename}" }) }
  filename
end

@lines = []
threads = []

# puts Sequentially
def process_file_sequentially(file)
  File.open(file, 'r') do |f|
    f.each_line { |line| @lines << line }
  end
end

start_time = Time.now

files.each do |file|
  threads << Thread.new do
    process_file_sequentially(file)
  end
end

threads.each(&:join)

end_time = Time.now

puts @lines
puts "Время выполнения Sequentially: #{end_time - start_time} секунд" # Время выполнения Sequentially: 0.306686048 секунд