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
p db.get("key") # => "value"
db.del("key")

db.close
```
