.PHONY: package
package: ./kyotocabinet-1.2.76/libkyotocabinet.a
UNAME := $(shell uname)

./kyotocabinet-1.2.76:
	wget http://fallabs.com/kyotocabinet/pkg/kyotocabinet-1.2.76.tar.gz
	tar -xzvf kyotocabinet-1.2.76.tar.gz

./kyotocabinet-1.2.76/libkyotocabinet.a: ./kyotocabinet-1.2.76
ifeq ($(UNAME), Linux)
	cd kyotocabinet-1.2.76 && ./configure && make libkyotocabinet.a
else
	cd kyotocabinet-1.2.76 && ./configure CXXFLAGS='-stdlib=libstdc++' && make libkyotocabinet.a
endif

.PHONY: clean
clean:
	rm kyotocabinet-1.2.76.tar.gz
	rm ./kyotocabinet-1.2.76/libkyotocabinet.a
	rm -rf ./kyotocabinet-1.2.76
	rm *.tag.gz*
