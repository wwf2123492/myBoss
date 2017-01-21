%%%-------------------------------------------------------------------
%%% @author h77
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 一月 2017 上午9:21
%%%-------------------------------------------------------------------
-module(myBoss_test_controller, [Req,SessionID]).
-author("h77").

%% API
-compile(export_all).

debug()->
  ok.




helloh('GET', [])->
  A = Req:query_params(),
  io:format("GEt sbw:...:::~p~n",[A]),
%  sbw:query_param(Req),
  B = case lists:keyfind(<<"www">>, 1, A) of
    {_, Val} -> Val;
    false -> "no"
  end,
  {ok, [{greeting, B}]}.

helloj('GET', [])->
  {json, [{greeting, "Hello, world!"}]}.

helloo('GET', [])->
  {output, "Hello, world!"}.

list('GET', [])->
  Greetings = boss_db:find(greeting,[]),
  {ok,[{greetings, Greetings}]}.

goodbye('POST', []) ->
  boss_db:delete(Req:post_param("greeting_id")),
  {redirect, [{action, "list"}]}.


create('GET', []) ->
  ok;
create('POST', []) ->
  GreetingText = Req:post_param("greeting_text"),
  if length(GreetingText) == 0 ->
    {ok, [{errors, ["lenth = 0"]}, {new_msg, "test"}]};
  true ->
    NewGreeting = greeting:new(id, GreetingText),
    NewGreeting:save(),
    boss_mq:push("new-greetings",NewGreeting),
      {redirect, [{action, "list"}]}
    end.


send_test_message('GET', []) ->
  TestMessage = "Free at last!",
  boss_mq:push("wwf", TestMessage),
  {output, TestMessage}.

pull('GET', [LastTimestamp]) ->
  {ok, Timestamp, Greetings} = boss_mq:pull("new-greetings",
    list_to_integer(LastTimestamp)),
  {json, [{timestamp, Timestamp}, {greetings, Greetings}]}.

live('GET', []) ->
  Greetings = boss_db:find(greeting, []),
  Timestamp = boss_mq:now("new-greetings"),
  {ok, [{greetings, Greetings}, {timestamp, Timestamp}]}.

g_session('GET',[Key1]) ->
  V = boss_session:get_session_data(SessionID,Key1),
  {output,V}.

update('GET',[Kid])->
  io:format("update get:~p",[Kid]),
  Greeting = boss_db:find(Kid),
  {ok,[{greeting,Greeting}]};

update('POST',[])->
 % Req:dump(),
  GreetingText = Req:post_param("greeting_text"),
  GreetingIndex = Req:post_param("greeting_id"),
  io:format("test:~p id:~p~n",[GreetingText,GreetingIndex]),
  Saved = boss_db:find(GreetingIndex),

  NewG = Saved:set(greeting_text,GreetingText),
  NewG:save(),
{redirect,"/test/list"}.




