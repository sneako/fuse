%%% @doc Simple one for one supervisor which dynamically starts fuse_servers.
%%% @private
-module(fuse_server_sup).
-behaviour(supervisor).

%% Callbacks
-export([init/1]).

%% @doc Start the fuse_server supervisor
%% @end
-spec start_link() -> {ok, pid()}.
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ------
%% @private
init(_Args) ->
    SupFlags = #{strategy => simple_one_for_one},
    ChildSpecs = [#{id => fuse_server,
                    start => {fuse_server, start_link, []},
                    shutdown => brutal_kill}],
    {ok, {SupFlags, ChildSpecs}}.
