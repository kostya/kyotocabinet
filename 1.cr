require "./src/kyotocabinet"

p 1

db = Kyotocabinet::Kc.kcdbnew
p db
p Kyotocabinet::Kc.kcdbopen(db, "1.kch", 6)
