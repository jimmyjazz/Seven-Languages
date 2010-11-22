File.open(ARGV[1]) do |file|
  file.each_line do |line|
    puts line if Regexp.new(ARGV[0]).match(line)
  end
end