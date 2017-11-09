require "leveldb"

db = LevelDB::DB.new("./1.db")
N = 500_000

t = Time.now
N.times do |i|
  db.put("bla#{i}", "jopa#{i}")
end
p "set #{Time.now - t}"

t = Time.now
s = 0
N.times do |i|
  s += db.get("bla#{i}").not_nil!.bytesize
end
p s
p "get #{Time.now - t}"

t = Time.now
s = 0
db.each do |k, v|
  s += k.bytesize + v.bytesize
end
p s
p "each #{Time.now - t}"

db.close
db.destroy
