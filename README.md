# kyotocabinet

Fast Persistent KeyValue Storage. Wrapper for [KyotoCabinet](http://fallabs.com/kyotocabinet/)

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
## Compare with LevelDB

| test                     | LevelDB | KyotoCabinet |
| ------------------------ | ------- | ------------ |
| 500K set                 | 3.96s   | 0.86s        |
| 500K get                 | 1.94s   | 0.57s        |
| iterate over all records | 0.21s   | 0.30s        |
| db size                  | 8.4Mb   | 26.2Mb       |
