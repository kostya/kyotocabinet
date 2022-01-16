module KyotoCabinet
  @[Link(ldflags: "#{__DIR__}/../ext/kyotocabinet-1.2.79/libkyotocabinet.a -lstdc++ -lm -lz")]
  lib Lib
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
    fun ecodename = kcecodename(code : Int32) : UInt8*
    fun dbemsg = kcdbemsg(db : KCDB) : UInt8*

    fun dbset = kcdbset(db : KCDB, kbuf : UInt8*, ksiz : LibC::SizeT, vbuf : UInt8*, vsiz : LibC::SizeT) : Int32
    fun dbadd = kcdbadd(db : KCDB, kbuf : UInt8*, ksiz : LibC::SizeT, vbuf : UInt8*, vsiz : LibC::SizeT) : Int32
    fun dbreplace = kcdbreplace(db : KCDB, kbuf : UInt8*, ksiz : LibC::SizeT, vbuf : UInt8*, vsiz : LibC::SizeT) : Int32

    fun dbremove = kcdbremove(db : KCDB, kbuf : UInt8*, ksiz : LibC::SizeT) : Int32
    fun dbget = kcdbget(db : KCDB, kbuf : UInt8*, ksiz : LibC::SizeT, sp : LibC::SizeT*) : UInt8*
    fun dbgetbuf = kcdbgetbuf(db : KCDB, kbuf : UInt8*, ksiz : LibC::SizeT, vbuf : UInt8*, max : LibC::SizeT) : Int32
    fun dbcheck = kcdbcheck(db : KCDB, kbuf : UInt8*, ksiz : LibC::SizeT) : Int32
    fun dbseize = kcdbseize(db : KCDB, kbuf : UInt8*, ksiz : LibC::SizeT, sp : LibC::SizeT*) : UInt8*

    fun dbclear = kcdbclear(db : KCDB) : Int32
    fun free = kcfree(ptr : Void*)

    # === stats ========
    fun dbcount = kcdbcount(db : KCDB) : Int64
    fun dbsize = kcdbsize(db : KCDB) : Int64
    fun dbpath = kcdbpath(db : KCDB) : UInt8*
    fun dbstatus = kcdbstatus(db : KCDB) : UInt8*

    # === cursor ======
    fun dbcursor = kcdbcursor(db : KCDB) : KCCUR
    fun curdel = kccurdel(cur : KCCUR)
    fun curget = kccurget(cur : KCCUR, ksp : LibC::SizeT*, vbp : UInt8**, vsp : LibC::SizeT*, step : Int32) : UInt8*
    fun curjump = kccurjump(cur : KCCUR) : Int32
  end
end
