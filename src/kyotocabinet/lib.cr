@[Link(ldflags: "#{__DIR__}/../ext/kyotocabinet-1.2.76/libkyotocabinet.a -lstdc++ -lm -lz")]
module Kyotocabinet
  lib Kc
    type KCDB = Void*

    fun kcdbnew : KCDB
    fun kcdbopen(db : KCDB, path : UInt8*, opts : Int32) : Int32
  end
end
