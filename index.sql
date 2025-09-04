-- Schema for the "console"
create schema if not exists console;

-- Helpfunction: creates the temp. table, if not existing
create or replace function console.ensure_table()
returns void as $$
begin
    -- temp. table for this session
    create temp table if not exists console_log (
        id serial primary key,
        level text not null,
        message text not null,
        created_at timestamptz default now()
    ) on commit preserve rows;
end;
$$ language plpgsql;

-- general logging-function
create or replace function console._write(level text, msg text)
returns void as $$
begin
    perform console.ensure_table(); -- sicherstellen, dass Tabelle existiert
    insert into console_log(level, message) VALUES (level, msg);
end;
$$ language plpgsql;

-- specific log-lvl
create or replace function console.log(msg text)
return void as $$
begin
    perform console._write('LOG', msg);
end;
$$ language plpgsql;

create or replace function console.info(msg text)
returns void as $$
begin
    perform console._write('INFO', msg);
end;
$$ language plpgsql;

create or replace function console.warn(msg text)
returns void as $$
begin
    perform console._write('WARN', msg);
end;
$$ language plpgsql;

create or replace function console.error(msg text)
returns void as $$
begin
    perform console._write('ERROR', msg);
end;
$$ language plpgsql;
