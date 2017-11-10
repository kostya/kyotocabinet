class KyotoCabinet::DB
  getter path

  def initialize(@path : String, @flags : Lib::Mode = Lib::Mode::KCOWRITER | Lib::Mode::KCOCREATE)
    @db = Lib.dbnew

    if Lib.dbopen(@db, @path, @flags) == 0
      raise Error.new("open '#{@path}' error '#{last_ecode_name}'")
    end

    @closed = false
  end

  def self.open(path, flags = Lib::Mode::KCOWRITER | Lib::Mode::KCOCREATE)
    db = self.new(path, flags)
    begin
      yield(db)
    ensure
      db.close
    end
  end

  def finalize
    close
  end

  def close
    unless @closed
      if Lib.dbclose(@db) == 0
        raise Error.new("close '#{@path}' error '#{last_ecode_name}'")
      end
      @closed = true
    end
  end

  @[AlwaysInline]
  def set(key : String, value : String)
    if Lib.dbset(@db, key, key.bytesize, value, value.bytesize) == 0
      raise Error.new("set error '#{last_ecode_name}'")
    end
    true
  end

  def []=(key, value)
    set(key, value)
  end

  @[AlwaysInline]
  def get(key : String)
    vbuf = Lib.dbget(@db, key, key.bytesize, out vsiz)
    unless vbuf.null?
      res = String.new(vbuf, vsiz)
      Lib.free(vbuf.as(Void*))
      res
    else
      # raise Error.new("get error '#{last_ecode_name}'")
      nil
    end
  end

  def [](key)
    get(key)
  end

  def has_key?(key : String)
    if Lib.dbcheck(@db, key, key.bytesize) == -1
      false
    else
      true
    end
  end

  # get and del
  def extract(key : String)
    vbuf = Lib.dbseize(@db, key, key.bytesize, out vsiz)
    unless vbuf.null?
      res = String.new(vbuf, vsiz)
      Lib.free(vbuf.as(Void*))
      res
    else
      # raise Error.new("get error '#{last_ecode_name}'")
      nil
    end
  end

  def del(key : String)
    if Lib.dbremove(@db, key, key.bytesize) == 0
      raise Error.new("del error '#{last_ecode_name}'")
    end
    true
  end

  def each
    cur = Lib.dbcursor(@db)
    begin
      Lib.curjump(cur)
      loop do
        kbuf = Lib.curget(cur, out ksiz, out cvbuf, out vsiz, 1)
        break if kbuf.null?
        key = String.new(kbuf, ksiz)
        value = String.new(cvbuf, vsiz)
        yield(key, value)
      end
    ensure
      Lib.curdel(cur)
    end
  end

  def drop!
    Lib.dbdel(@db)
  end

  def clear!
    if Lib.dbclear(@db) == 0
      raise Error.new("clear error '#{last_ecode_name}'")
    end
    true
  end

  def count
    Lib.dbcount(@db)
  end

  def size
    Lib.dbsize(@db)
  end

  def status
    s = Lib.dbstatus(@db)
    res = String.new(s)
    Lib.free(s.as(Void*))
    res
  end

  private def last_ecode
    Lib.dbecode(@db)
  end

  private def last_ecode_name
    String.new(Lib.ecodename(last_ecode))
  end
end
