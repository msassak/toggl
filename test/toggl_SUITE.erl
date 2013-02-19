-module(toggl_SUITE).
-compile(export_all).
-include_lib("common_test/include/ct.hrl").

all() -> [toggl_test].

toggl_test(_) ->
    ok = toggl:start(),
    false = toggl:is_on(new_feature),
    ok = toggl:turn_on(new_feature),
    true = toggl:is_on(new_feature),
    ok = toggl:turn_off(new_feature),
    false = toggl:is_on(new_feature).
