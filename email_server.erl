-module(email_server).
-behaviour(gen_server).

-export([start_link/0]).
-export([alloc/0, free/1]).
-export([init/1, handle_call/3, handle_cast/2]).
-export([code_change/3]).

%
% Implementations from
% http://www.erlang.org/doc/design_principles/gen_server_concepts.html
%

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

alloc() ->
    gen_server:call(?MODULE, alloc).

free(Ch) ->
    gen_server:cast(?MODULE, {free, Ch}).

init(_Args) ->
    {ok, channels()}.

handle_call(alloc, _From, Chs) ->
    {Ch, Chs2} = alloc(Chs),
    {reply, Ch, Chs2}.

handle_cast({free, Ch}, Chs) ->
    Chs2 = free(Ch, Chs),
    {noreply, Chs2}.

%
% Copied from http://bytefilia.com/erlang-otp-gen_server-template-example/
%

code_change(_OldVersion, _Server, _Extra) ->
    {ok, _Server}.

%
% Sample implementations from
% http://www.erlang.org/doc/design_principles/des_princ.html#ch1
%

channels() ->
   {_Allocated = [], _Free = lists:seq(1,100)}.

alloc({Allocated, [H|T] = _Free}) ->
   {H, {[H|Allocated], T}}.

free(Ch, {Alloc, Free} = Channels) ->
   case lists:member(Ch, Alloc) of
      true ->
         {lists:delete(Ch, Alloc), [Ch|Free]};
      false ->
         Channels
   end. 
