%%%-------------------------------------------------------------------
%%% @author h77
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 一月 2017 下午5:35
%%%-------------------------------------------------------------------
-module(myBoss_s_controller,[Req,SessionID]).
-author("h77").

%% API
-compile(export_all).



s_session('GET',[Key1,Value])->
  boss_session:set_session_data(SessionID, Key1, Value),

{output,"ok save :"}.

g_session('GET',[Key1]) ->
  V = boss_session:get_session_data(SessionID,Key1),
  {output,V}.