require "../src/kyotocabinet"

db = KyotoCabinet::DB.new("./1.kch")

db.set("key", "value")
p db.get("key") # => "value"
db.del("key")

db.close
