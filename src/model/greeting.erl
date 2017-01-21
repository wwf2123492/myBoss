%%%-------------------------------------------------------------------
%%% @author h77
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 一月 2017 上午9:43
%%%-------------------------------------------------------------------
-module(greeting,[Id, GreetingText]).
-author("h77").

%% API
-compile(expor_all).


validation_tests() ->
  [{fun() -> length(GreetingText) > 0 end,
    "Greeting must be non-empty!"},
    {fun() -> length(GreetingText) =< 140 end,
      "Greeting must be tweetable"}].


after_create() ->
  boss_mq:push("new-greetings", THIS).