-module(mail_sender).

-export([get_socket/0, get_socket/1, send_msg/2]).

get_socket() ->
    get_socket({127,0,0,1}).
get_socket(IP) ->
    {ok, Socket} = gen_tcp:connect(IP, 25, [binary, {active,true}]),
    Socket.

send_msg(Socket, Msg) ->
    gen_tcp:send(Socket, Msg).
