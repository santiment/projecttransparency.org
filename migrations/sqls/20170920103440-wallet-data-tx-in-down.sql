begin;

alter table wallet_data
alter column tx_in type integer;

commit;