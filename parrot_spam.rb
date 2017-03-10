#! /usr/bin/env ruby

parrots = ARGV.reject(&:empty?)
if parrots.empty?
  STDERR.puts "Nothing to repeat"
  exit 1
end

chars_left = 4000

parrots.cycle.each do |p|
  chars_left -= p.length
  break if chars_left < 0

  print p
end

puts if STDOUT.isatty
