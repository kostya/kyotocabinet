.PHONY: package
package: ./kyotocabinet-1.2.76/libkyotocabinet.a

./kyotocabinet-1.2.76:
	wget http://fallabs.com/kyotocabinet/pkg/kyotocabinet-1.2.76.tar.gz
	tar -xzvf kyotocabinet-1.2.76.tar.gz

./kyotocabinet-1.2.76/libkyotocabinet.a: ./kyotocabinet-1.2.76
	cd kyotocabinet-1.2.76 && ./configure CXXFLAGS='-stdlib=libstdc++' && make libkyotocabinet.a

.PHONY: clean
clean:
	rm kyotocabinet-1.2.76.tar.gz
	rm ./kyotocabinet-1.2.76/libkyotocabinet.a
	rm -rf ./kyotocabinet-1.2.76
	rm *.tag.gz*
