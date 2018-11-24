%%%-------------------------------------------------------------------
%%% @author Mawuli Adzaku <mawuli@mawuli.me>
%%% @copyright (C) 2014, Mawuli Adzaku
%%% @doc
%%% Company data generator
%%% @end
%%% Created :  5 Feb 2014 by Mawuli Adzaku <mawuli@mawuli.me>
%%%-------------------------------------------------------------------
-module(fakerl_company).
-include("fakerl.hrl").

-export([
          bs/0,
          bs/1,
          buzzwords/0,
          buzzwords/1,
          catch_phrase/2,
          dept/0,
          dept/1,
          name/0,
          suffix/0
        ]).

%% @doc Returns a full company name
-spec name() -> string().
name() ->
    fakerl:parse("company.name").

%% @doc Retruns a full company name
-spec dept() -> string().
dept() ->
  dept(fakerl:random(2, 4)).

dept(Length) ->
  BsLength = fakerl:random(1, Length),
  BuzzLength = Length - BsLength,
  Words = string:titlecase(fakerl:shuffle(
            lists:merge([
              catch_phrase_list("bs", BsLength),
              catch_phrase_list("buzzwords", BuzzLength)
            ])
          )),
  string:join(
    lists:merge(Words,
                fakerl:random_element([
                  "",
                  fakerl:fetch("company.dept_suffix")

                ])),
    " ").


%% @doc Returns a company name suffix
%% Examples: Ltd, Inc, Group
-spec suffix() -> string().
suffix() ->
    fakerl:fetch("company.suffix").

%% @doc Returns a string of buzzwords.
-spec buzzwords() -> string().
buzzwords() ->
    catch_phrase("buzzwords", ?CATCH_PHRASE_LENGTH).

-spec buzzwords(integer()) -> string().
buzzwords(Length) when is_integer(Length) ->
    catch_phrase("buzzwords", Length).

%% @doc Returns a string totally nonsensical words.
-spec bs() -> string().
bs() ->
    catch_phrase("bs", ?CATCH_PHRASE_LENGTH).

-spec bs(integer()) -> string().
bs(Length) ->
    catch_phrase("bs", Length).


%% @doc Returns a catch phrase of length Length from the given section
%% under the company node of the locale file.
-spec catch_phrase(Section, Length) -> string when
      Section :: string(),
      Length  :: integer().
catch_phrase(_Section, 0) -> "";
catch_phrase(Section, Length) ->
  case string:join(catch_phrase_list(Section, Length), " ") of
      "" ->
          catch_phrase(Section, Length);
      Phrase ->
          Phrase
  end.

%% @doc Returns a catch phrase of length Length from the given section
%% under the company node of the locale file.
-spec catch_phrase_list(Section, Length) -> list() when
      Section :: string(),
      Length  :: integer().
catch_phrase_list(Section, Length) ->
    MaxNum = Length * fakerl:random_number(),
    Words = [
              fakerl:fetch("company." ++ Section)
              || _X <- lists:seq(1, MaxNum)
            ],
    Words1 = fakerl:shuffle(lists:merge(Words)),
    lists:sublist(Words1, Length).
