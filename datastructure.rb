#iterate hash

hash = Hash.new

hash = {
  1 => ['Evan'],
  2 => ['Lyu'],
  3 => ['732'],
}

hash.each do |key, array|
  puts '#{key}----'
  puts array
end
