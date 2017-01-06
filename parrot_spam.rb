#! /usr/bin/env ruby

unless ARGV.find { |arg| arg.length > 0 }
  STDERR.puts "Nothing to repeat"
  exit 1
end

chars_left = 4000

ARGV.cycle.each do |arg|
  chars_left -= arg.length
  break if chars_left < 0
  
  print arg
end

puts
