#!/usr/bin/ruby

require "find"
require "time"

rpath = "/usr/bin/ruby"
#rpath = "/home/nbook/ruby-concurrent-gc/miniruby"
exclude = [
    "revcomp-2", "regexdna-1", "regexdna-2", "regexdna-4", "knucleotide-2", "knucleotide-3", # take too long
    "knucleotide-1", "mandelbrot-2", "regexdna-3", # Process.fork
    "chameneosredux-1", "fannkuchredux-1", "nbody-2", "pidigits-1", "spectralnorm-1", "spectralnorm-2", "spectralnorm-4", # requires full ruby
    ]

# unused, but example structure plan...
tests = [
    { :name => "revcomp", :testno => 2, :exlude => true }, # take too long
    { :name => "binarytree", :testno => 1, :exclude => false, :inputarr => ["10"] }
]

Find.find "." do |fpath|
    if fpath =~ /.+\.jruby$/
	fname = File.basename(fpath, ".jruby")
	fdir = File.basename(File.dirname(fpath))
	if exclude.include?("#{fdir}-#{fname}")
	    puts "Excluded: #{fdir} #{fname}"
	else
	    puts "Test: #{fdir} #{fname}"
	    t1 = Time.now
	    %x[#{rpath} #{fpath}]
	    ret = $?
	    t2 = Time.now
	    time = (t2 - t1)
	    time_s = " (#{time} seconds)"
	    if ret.exitstatus != 0
		time_s = ""
	    end
	    puts "Result: #{ret}#{time_s}"
	end
    end
end
