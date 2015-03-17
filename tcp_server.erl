-module(tcp_server).

-export([get_socket/0, get_connection/1, write_tmp/1, loop/1]).

get_socket() ->
    {ok, ListenSocket} = gen_tcp:listen(25, [{active,true}, binary]),
    ListenSocket.

get_connection(ListenSocket) ->
    {ok, AcceptSocket} = gen_tcp:accept(ListenSocket),
    AcceptSocket.

handle_connection(AcceptSocket) ->
    io:format("Handling new connection.~n", []),
    gen_tcp:close(AcceptSocket).

write_tmp(Data) ->
    write_tmp("/tmp", Data).
write_tmp(Path, Data) ->
    file:write_file(Path, Data).

%
% Make sure this is actually concurrent (?).
%

loop(ListenSocket) ->
    Accept = get_connection(ListenSocket),
    handle_connection(Accept), % (!)
    loop(ListenSocket).
