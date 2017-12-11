begin;

ALTER TABLE cmm_data
ALTER COLUMN market_cap DROP NOT NULL,
ALTER COLUMN price_usd DROP NOT NULL;

commit;