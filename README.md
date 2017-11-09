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
