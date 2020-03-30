create table user_session (
    sessionID integer,
    ipAdd inet,
    clicks integer,
    ts TIMESTAMP,
    tstz TIMESTAMPTZ
);

SET timezone = 'Europe/Istanbul';
