h = {
  :one => 1,
  :two => 2
}

h[:one]
h[:three]=3
h.each do |key,value|
  print '#{value}:#{key}'
end
