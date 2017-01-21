%%%-------------------------------------------------------------------
%%% @author h77
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 一月 2017 下午3:54
%%%-------------------------------------------------------------------
-module(myBoss_dong_controller,[Req]).
-compile(export_all).

%% API
-export([]).



up('GET',[Pname , CR , Cms , AR , Ams , Ping ,V])->
  DongData = dongdata:new(id, Pname,CR,Cms,AR,Ams,Ping,V),
  DongData:save(),
  {output,"ok"}.