%%%-------------------------------------------------------------------
%%% @author Mawuli Adzaku <mawuli@mawuli.me>
%%% @copyright (C) 2014, Mawuli Adzaku
%%% @doc
%%% Generates fake addresses
%%% @end
%%% Created : 31 Jan 2014 by Mawuli Adzaku <mawuli@mawuli.me>
%%%-------------------------------------------------------------------
-module(fakerl_address).
-author("Mawuli Adzaku <mawuli@mawuli.me>").
-export([
         address/0,
         building_number/0,
         cities/0,
         city/0,
         city_suffix/0,
         countries/0,
         country/0,
         geo_coordinate/0,
         latitude/0,
         longitude/0,
         postcode/0,
         state/0,
         state_abbr/0,
         street_address/0,
         street_name/0,
         street_suffix/0
        ]).



%%%-------------------------------------------------------------------
%%%  API
%%%-------------------------------------------------------------------

countries() ->
    fakerl:fetch("address.countries").

cities() ->
    fakerl:fetch("address.cities").

city_suffix() ->
    fakerl:fetch("address.city_suffix").

street_suffix() ->
    fakerl:fetch("address.street_suffix").

building_number() ->
    Format = fakerl:fetch("address.building_number"),
    fakerl:numerify(Format).

city() ->
    Format = fakerl:fetch("address.city"),
    fakerl:parse(Format, ?MODULE).

state() ->
    fakerl:fetch("address.state").

state_abbr() ->
    fakerl:fetch("address.state_abbr").

street_name() ->
    fakerl:parse("{{ address.street_name }}", ?MODULE).

street_address() ->
    Format = fakerl:fetch("address.street_address"),
    fakerl:parse(Format, ?MODULE).

postcode() ->
    Format = fakerl:fetch("address.postcode"),
    fakerl:numerify(Format).

%% @doc Generate an address
%% Example: '791 Crist Parks, Sashabury, IL 86039-9874'
address() ->
    fakerl:parse("{{ address.address }}", ?MODULE).

country() ->
    fakerl:fetch("address.country").

geo_coordinate() ->
    {latitude(), longitude()}.

%% @doc Returns a laitude co-ordinate
latitude() ->
   ((rand:uniform() * 180) - 90).

%% @doc Returns a longitude co-ordinate
longitude() ->
   ((rand:uniform() * 360) - 180).
