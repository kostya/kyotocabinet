.PHONY: package
package: ./kyotocabinet-1.2.79/libkyotocabinet.a
UNAME := $(shell uname)

./kyotocabinet-1.2.79:
	wget http://fallabs.com/kyotocabinet/pkg/kyotocabinet-1.2.79.tar.gz
	tar -xzvf kyotocabinet-1.2.79.tar.gz

./kyotocabinet-1.2.79/libkyotocabinet.a: ./kyotocabinet-1.2.79
ifeq ($(UNAME), Linux)
	cd kyotocabinet-1.2.79 && ./configure && make libkyotocabinet.a
else
	cd kyotocabinet-1.2.79 && ./configure CXXFLAGS='-stdlib=libstdc++' && make libkyotocabinet.a
endif

.PHONY: clean
clean:
	rm kyotocabinet-1.2.79.tar.gz
	rm ./kyotocabinet-1.2.79/libkyotocabinet.a
	rm -rf ./kyotocabinet-1.2.79
	rm *.tag.gz*
