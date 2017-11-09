@[Link(ldflags: "#{__DIR__}/../ext/kyotocabinet-1.2.76/libkyotocabinet.a -lstdc++ -lm -lz")]
module Kyotocabinet
  lib Kc
    type KCDB = Void*
    type KCCUR = Void*
    type KCSTR = Void*
    type KCREC = Void*

    enum ErrorCode : UInt32
      KCESUCCESS      # /**< success */
      KCENOIMPL       # /**< not implemented */
      KCEINVALID      # /**< invalid operation */
      KCENOREPOS      # /**< no repository */
      KCENOPERM       # /**< no permission */
      KCEBROKEN       # /**< broken file */
      KCEDUPREC       # /**< record duplication */
      KCENOREC        # /**< no record */
      KCELOGIC        # /**< logical inconsistency */
      KCESYSTEM       # /**< system error */
      KCEMISC    = 15 #  /**< miscellaneous error */
    end

    # Merge modes.
    enum MergeNodes
      KCMSET     # /**< overwrite the existing value */
      KCMADD     # /**< keep the existing value */
      KCMREPLACE # /**< modify the existing record only */
      KCMAPPEND  # /**< append the new value */
    end

    # Open modes.
    enum Mode : UInt32
      KCOREADER   = 1 << 0 # /**< open as a reader */
      KCOWRITER   = 1 << 1 # /**< open as a writer */
      KCOCREATE   = 1 << 2 # /**< writer creating */
      KCOTRUNCATE = 1 << 3 # /**< writer truncating */
      KCOAUTOTRAN = 1 << 4 # /**< auto transaction */
      KCOAUTOSYNC = 1 << 5 # /**< auto synchronization */
      KCONOLOCK   = 1 << 6 # /**< open without locking */
      KCOTRYLOCK  = 1 << 7 # /**< lock without blocking */
      KCONOREPAIR = 1 << 8 # /**< open without auto repair */
    end

    fun dbnew = kcdbnew : KCDB
    fun dbdel = kcdbdel(db : KCDB)
    fun dbopen = kcdbopen(db : KCDB, path : UInt8*, mode : Mode) : Int32
    fun dbclose = kcdbclose(db : KCDB) : Int32
    fun dbecode = kcdbecode(db : KCDB) : Int32
    fun dbemsg = kcdbemsg(db : KCDB) : UInt8*
  end
end
