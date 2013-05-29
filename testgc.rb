GC.start
puts GC.stat
b = []
5000.times do |i|
    b = [ {:a=>1} ]
end
puts b.length
puts GC.stat

