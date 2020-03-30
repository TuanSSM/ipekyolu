create table order_item_history (
    sequenceID integer,
    amount integer,
    order_state varchar(16),
    notes varchar(280),
    ts timestamp
   );
