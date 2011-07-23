%% Copyright (c) 2011 Nick Campbell 
%% Distributed under the MIT license; see LICENSE for details.
-module(jade_utils).
-author('Nick Campbell <nicholas.j.campbell@gmail.com>').

-export([read_lines_from_file/3]).

% functions found at http://www.trapexit.org/Reading_Lines_from_a_File
% copyright and licensing from there.
read_lines_from_file(Path, Proc, Accum) ->
  {ok, Device} = file:open(Path, [read]),
  get_lines(Device, Proc, Accum).

get_lines(Device, Proc, Accum) ->
  case io:get_line(Device, "") of
      eof -> file:close(Device), Accum;
      Line -> NewAccum = Proc(Line, Accum),
        from_file({device, Device}, Proc, NewAccum)
    end.
