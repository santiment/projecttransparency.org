begin;

update cmm_data
set market_cap = coalesce(market_cap, 0)
    , price_usd = coalesce(price_usd, 0)
where market_cap is null
	or price_usd is null;

ALTER TABLE cmm_data
ALTER COLUMN market_cap SET NOT NULL,
ALTER COLUMN price_usd SET NOT NULL;

commit;