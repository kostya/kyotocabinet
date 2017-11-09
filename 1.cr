require "./src/kyotocabinet"

db = Kyotocabinet::Lib.dbnew
if Kyotocabinet::Lib.dbopen(db, "1.kch", Kyotocabinet::Lib::Mode::KCOWRITER | Kyotocabinet::Lib::Mode::KCOCREATE) == 0
  raise "open error #{String.new(Kyotocabinet::Lib.ecodename(Kyotocabinet::Lib.dbecode(db)))}"
end

Kyotocabinet::Lib.dbset(db, "foo", 3, "hop", 3)

ch = Kyotocabinet::Lib.dbget(db, "foo", 3, out size)
p String.new(ch, size)

# /* main routine */
# int main(int argc, char** argv) {
#   KCDB* db;
#   KCCUR* cur;
#   char *kbuf, *vbuf;
#   size_t ksiz, vsiz;
#   const char *cvbuf;

#   /* store records */
#   if (!kcdbset(db, "foo", 3, "hop", 3) ||
#       !kcdbset(db, "bar", 3, "step", 4) ||
#       !kcdbset(db, "baz", 3, "jump", 4)) {
#     fprintf(stderr, "set error: %s\n", kcecodename(kcdbecode(db)));
#   }

#   /* retrieve a record */
#   vbuf = kcdbget(db, "foo", 3, &vsiz);
#   if (vbuf) {
#     printf("%s\n", vbuf);
#     kcfree(vbuf);
#   } else {
#     fprintf(stderr, "get error: %s\n", kcecodename(kcdbecode(db)));
#   }

#   /* traverse records */
#   cur = kcdbcursor(db);
#   kccurjump(cur);
#   while ((kbuf = kccurget(cur, &ksiz, &cvbuf, &vsiz, 1)) != NULL) {
#     printf("%s:%s\n", kbuf, cvbuf);
#     kcfree(kbuf);
#   }
#   kccurdel(cur);

#   /* retrieve a record with visitor */
#   if (!kcdbaccept(db, "foo", 3, visitfull, visitempty, NULL, 0) ||
#       !kcdbaccept(db, "dummy", 5, visitfull, visitempty, NULL, 0)) {
#     fprintf(stderr, "accept error: %s\n", kcecodename(kcdbecode(db)));
#   }

#   /* traverse records with visitor */
#   if (!kcdbiterate(db, visitfull, NULL, 0)) {
#     fprintf(stderr, "iterate error: %s\n", kcecodename(kcdbecode(db)));
#   }

#   /* close the database */
#   if (!kcdbclose(db)) {
#     fprintf(stderr, "close error: %s\n", kcecodename(kcdbecode(db)));
#   }

#   /* delete the database object */
#   kcdbdel(db);

#   return 0;
# }
