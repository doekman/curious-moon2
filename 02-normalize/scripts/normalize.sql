-- TEAM
create materialized view if not exists teams as
    with pre_teams as (
        select distinct team as description
        from import.master_plan
        where team is not null
    )
    select row_number() over (order by description) id
    ,      description
    from pre_teams
;

-- SPASS TYPES
create materialized view if not exists spass_types as
    with pre_spass_type as (
        select distinct spass_type as description
        from import.master_plan
        where spass_type is not null
    )
    select row_number() over (order by description) id
    ,      description
    from pre_spass_type
;

-- TARGET
create materialized view if not exists targets as
    with pre_targets as (
        select distinct target as description
        from import.master_plan
        where target is not null
    )
    select row_number() over (order by description) id
    ,      description
    from pre_targets
;

-- EVENT TYPES
create materialized view if not exists event_types as
    with pre_event_types as (
        select distinct library_definition as description
        from import.master_plan
        where library_definition is not null
    )
    select row_number() over (order by description) id
    ,      description
    from pre_event_types
;

--REQUESTS
create materialized view if not exists requests as
    with pre_requests as (
        select distinct request_name as description
        from import.master_plan
    )
    select row_number() over (order by description) id
    ,      description
    from pre_requests
;


--EVENTS
create materialized view events as
    select import.master_plan.start_time_utc::timestamp
    ,      import.master_plan.title
    ,      import.master_plan.description
    ,      event_types.id as event_type_id
    ,      targets.id as target_id
    ,      teams.id as team_id
    ,      requests.id as request_id
    ,      spass_types.id as spass_type_id
    from import.master_plan
    left join event_types on event_types.description = import.master_plan.library_definition
    left join targets     on targets.description     = import.master_plan.target
    left join teams       on teams.description       = import.master_plan.team
    left join requests    on requests.description    = import.master_plan.request_name
    left join spass_types on spass_types.description = import.master_plan.spass_type
;
