-module(tgl_server).
-behavior(gen_server).

% API
-export([start_link/0, turn_on/1, turn_off/1, is_on/1]).

% Callbacks
-export([
    init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3
]).

-define(SERVER, ?MODULE).

-record(state, {toggles}).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

turn_on(Feature) ->
    ok = gen_server:call(?SERVER, {turn_on, Feature}).

turn_off(Feature) ->
    ok = gen_server:call(?SERVER, {turn_off, Feature}).

is_on(Feature) ->
    {ok, Result} = gen_server:call(?SERVER, {is_on, Feature}), Result.

init([]) ->
    {ok, #state{ toggles = dict:new() }}.

handle_call({turn_on, Feature}, _, #state{ toggles = T }) ->
    {reply, ok, #state{ toggles = dict:store(Feature, on, T) }};
handle_call({turn_off, Feature}, _, #state{ toggles = T }) ->
    {reply, ok, #state{ toggles = dict:erase(Feature, T) }};
handle_call({is_on, Feature}, _, #state{ toggles = T } = S) ->
    {reply, {ok, dict:is_key(Feature, T)}, S}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_, State, _) ->
    {ok, State}.
