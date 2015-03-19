-module(email_server).
-behaviour(gen_server).

-export([start_link/0, init/1,
         handle_call/3,
         handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start/0, stop/0]).

% http://www.erlang.org/doc/design_principles/gen_server_concepts.html

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, null}.


handle_call(stop, _From, State) ->
    {stop, normal, stopped, State};

handle_call(_Request, _From, State) ->
    Reply = null,
    {reply, Reply, State}.

handle_cast(_Msg, State) -> {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVer, State, _Extra) -> {ok, State}.


%
% Interface routines
%

start() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop() -> gen_server:call(?MODULE, stop).
