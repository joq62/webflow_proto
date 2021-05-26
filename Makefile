PROJECT = websocket
PROJECT_DESCRIPTION = Cowboy Websocket example
PROJECT_VERSION = 1

DEPS = cowboy
dep_cowboy_commit = master

include erlang.mk 
# Joq Erlang code
c1:
	rm -rf deps;
	rm -rf */*.beam *~ */*~
git:
	rm -rf */*.beam *~ */*~;
	cp src/*.app ebin;
	erlc -o ebin src/*.erl;
	cp deps/cowboy/ebin/* ebin;
	cp deps/ranch/ebin/* ebin;
	cp deps/cowlib/ebin/* ebin;
	rm -rf deps
#	erl -pa ebin -run webflow_proto boot -sname webflow_proto
websocket:
	rm -rf */*.beam *~ */*~;
	cp src/*.app ebin;
	erlc -o ebin src/*.erl;
	erl -pa deps/cowboy/ebin -pa deps/ranch/ebin -pa deps/cowlib/ebin -pa ebin -run webflow_proto boot -sname webflow_proto
