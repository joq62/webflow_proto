%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(websocket_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.
start(_Type, _Args) ->
    
%    IndexRoute={ "/", cowboy_static, {priv_file, webflow_proto, "index.html"} },
%    HandlerRoute={"/please_upgrade_to_websocket", myws_handler, []},
%    CatchAllRoute={"/[...]", no_matching_route_handler, []},
    {ok,Port}=application:get_env(port),
    {ok,IndexRoute}=application:get_env(index_route),
    {ok,HandlerRoute}=application:get_env(handler_route),
    {ok,CatchAllRoute}=application:get_env(catch_route),
    io:format("~p~n",[{Port}]),
    io:format("~p~n",[{IndexRoute}]),
    io:format("~p~n",[{HandlerRoute}]),
    io:format("~p~n",[{CatchAllRoute}]),
    
%    HelloRoute = { "/", cowboy_static, {priv_file, webflow_proto, "index.html"} },
%    WebSocketRoute = {"/please_upgrade_to_websocket", myws_handler, []},
%    CatchallRoute = {"/[...]", no_matching_route_handler, []},

    Dispatch = cowboy_router:compile([
				      {'_',
				       [
					IndexRoute,
					HandlerRoute,
					CatchAllRoute
				%	HelloRoute, 
				%	WebSocketRoute, 
			%		CatchallRoute
				       ]
				      }
				     ]),
    {ok, _} = cowboy:start_clear(http, [{port, Port}], #{
							 env => #{dispatch => Dispatch}
							}),
    ssl:start(),
    application:start(crypto),
    application:start(ranch), 
    application:start(cowlib), 
    application:start(cowboy),
    R=websocket_sup:start_link(),
    io:format("Websocket started R, listning port   ~p~n",[{R,8080,?MODULE,?LINE}]),
    R.

stop(_State) ->
    ok = cowboy:stop_listener(http).
