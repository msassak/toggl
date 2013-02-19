-module(toggl).

%% API
-export([is_on/1, turn_on/1, turn_off/1]).

%% Utility API
-export([start/0, stop/0]).

is_on(Feature) -> 
    tgl_server:is_on(Feature).

turn_on(Feature) ->
    tgl_server:turn_on(Feature).

turn_off(Feature) ->
    tgl_server:turn_off(Feature).

start() ->
    application:start(toggl).

stop() ->
    application:stop(toggl).
