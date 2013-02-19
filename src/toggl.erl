-module(toggl).

%% API
-export([is_on/1, turn_on/1]).

%% Utility API
-export([start/0, stop/0]).

is_on(Feature) -> 
    {ok, Result} = tgl_server:is_on(Feature), Result.

turn_on(Feature) ->
    ok = tgl_server:turn_on(Feature).

start() ->
    application:start(toggl).

stop() ->
    application:stop(toggl).

