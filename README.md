# kyotocabinet

Fast Persistent Embedded KeyValue Storage. Wrapper for [KyotoCabinet](http://fallabs.com/kyotocabinet/)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  kyotocabinet:
    github: kostya/kyotocabinet
```

## Usage

```crystal
require "kyotocabinet"

db = KyotoCabinet::DB.new("./1.kch")

db.set("key", "value")
db["key2"] = "value2"

p db.get("key") # => "value"
p db["key2"] # => "value2"

db.del("key")

db.each do |key, value|
  p "#{key} = #{value}"
end

db.close
```
## Compare with [LevelDB](https://github.com/crystal-community/leveldb)

| test                     | LevelDB | KyotoCabinet |
| ------------------------ | ------- | ------------ |
| 1mln set                 | 3.66s   | 1.00s        |
| 1mln get                 | 1.95s   | 0.63s        |
| iterate over all records | 0.27s   | 0.31s        |
| db size                  | 16Mb    | 45Mb         |
