segs = %x[ipcs -a].split("\n")
segs.each do |seg|
  flds = seg.split
  if seg[0]=="m"
    if flds[9].to_i == 800000 or flds[9].to_i == 48
      %x[ipcrm -m #{flds[1]}]
    end
  end
end
