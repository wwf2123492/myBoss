%%%-------------------------------------------------------------------
%%% @author h77
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 一月 2017 下午10:05
%%%-------------------------------------------------------------------
-module(myBoss_file_controller, [Req,SessionID]).
-author("h77").

%% API
-compile(export_all).
up('GET',[])->
  io:format("file up get!!!!~n"),
  {ok,{wwf,"wwf"}};
up('POST',[])->
  {sb_uploaded_file,Ofile,Tfile,FSize,SubName,_} = Req:post_files(),
  io:format("file up post:~p~n",Tfile),
  {output,Tfile}.



%sb_uploaded_file exports the following functions:

%sb_uploaded_file:original_name(UploadedFile) - The original name of the file from the user's system
%sb_uploaded_file:temp_file(UploadedFile) - The temporary name for the file as it's stored on the server. Returns undefined if file is kept in memory.
%sb_uploaded_file:size(UploadedFile) - The size of the file in bytes
%sb_uploaded_file:field_name(UploadedFile) - The name of the HTML <input type=file> element from the page.
%sb_uploaded_file:data(UploadedFile)

%{sb_uploaded_file,"start.sh",
%"./scratch/197-222-207-226-143-233-43-121-80-42-54-99-188-138-86-31",
%41,"fileField",undefined}