-module(tgl_server).
-behavior(gen_server).

% API
-export([start_link/0, turn_on/1, is_on/1]).

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
    gen_server:call(?SERVER, {turn_on, Feature}).

is_on(Feature) ->
    gen_server:call(?SERVER, {is_on, Feature}).

init([]) ->
    {ok, #state{ toggles = dict:new() }}.

handle_call({turn_on, Feature}, _, State) ->
    Toggles = State#state.toggles,
    {reply, ok, #state{ toggles = dict:store(Feature, on, Toggles) }};
handle_call({is_on, Feature}, _, State) ->
    Toggles = State#state.toggles,
    {reply, {ok, dict:is_key(Feature, Toggles)}, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_, State, _) ->
    {ok, State}.
