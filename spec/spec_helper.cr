require "spec"
require "../src/kyotocabinet"

def spec_db_name(name)
  "#{__DIR__}/.dbs/#{name}"
end

Spec.before_each do
  Dir["#{__DIR__}/.dbs/*.kch"].each do |name|
    File.delete(name)
  end
end
