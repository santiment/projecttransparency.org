/* Populate database with projecttransparency data */
INSERT INTO project (ticker, name, coinmarketcap_id) VALUES
  ('ADX', 'AdEx Network', 'adx-net'),
  ('ANT', 'Aragon', 'aragon'),
  /* ('', 'Attores'), */
  ('AVT', 'Aventus', 'aventus'),
  ('CORC', 'CellR Lab', null),
  ('CLICK', 'Clickle', null),
  ('CFI', 'Cofound.it', 'cofound-it'),
  ('C20', 'Crypto20', null),
  ('DAP', 'Dappbase', null),
  ('DGD', 'DigixDAO', 'digixdao'),
  ('DNT', 'district0x', 'district0x'),
  ('DNA', 'Encrypgen', 'encrypgen'),
  ('RSC', 'Etherisc', null),
  ('EXP/LAB', 'Expanse/Tokenlab', null),
  ('XSB', 'Extreme Sportsbook', null),
  ('GAT', 'Gatcoin.io', null),
  ('GRV', 'Gravel Coin', null),
  ('HLN', 'Hellenium', null),
  ('HSR', 'Hshare', 'hshare'),
  ('ICN', 'Iconomi', 'iconomi'),
  ('IND', 'Indorse', 'indorse-token'),
  ('ICNQ', 'IconiqLab', null),
  /* ('KPMG', 'KPMG'), */
  ('LLA', 'Lalena', null),
  ('PHT', 'Lightstreams Network', null),
  ('LKK', 'Lykke', 'lykke'),
  ('ART', 'Maecenas', 'maecenas'),
  ('MTL', 'Metal', 'metal'),
  ('MISC', 'Misscoin', null),
  ('MCI', 'Musiconomi', null),
  ('OHNI', 'Ohni', null),
  ('SAN', 'Santiment', 'santiment'),
  ('SLR', 'SolarCoin', 'solarcoin'),
  ('SNM', 'SONM', 'sonm'),
  ('SNT', 'Status.im', 'status'),
  ('VIC', 'Virgil Capital', null),
  ('WRL', 'Wireline', null)

ON CONFLICT (name) DO UPDATE
  SET (ticker, coinmarketcap_id) = (EXCLUDED.ticker, EXCLUDED.coinmarketcap_id);

/* Insert known addresses */
INSERT INTO project_eth_address (project_id, address)
  SELECT
    project.id,
    t.address
  FROM
    project,
    (VALUES
      ('AdEx Network', '0x4470BB87d77b963A013DB939BE332f927f2b992e'),
      ('Aragon', '0xcafe1a77e84698c83ca8931f54a755176ef75f2c'),
      ('Aventus', '0x035a401972f228b58dcae76bf318b54ed036d680'),
      ('CellR Lab', '0x4Be816E8c192D6145B8c84579FbAf258f26a358A'),
      ('Clickle', '0xA38bC010c2bcC0C453383E43CbC17e4717564392'),
      ('Cofound.it', '0xe328dfcE5C44B2587B54d10E1016971E3a03d448'),
      ('Cofound.it', '0xdb837Cf3522c445C4472A74157872491516553A3'),
      ('Cofound.it', '0x3013D62a7357021259C3ee463Ec9FBC64DE7bA76'),
      ('Cofound.it', '0x67Faa7A9700f22E7c88CF7E099e58BAF59a45Fbb'),
      ('DigixDAO', '0xf0160428a8552ac9bb7e050d90eeade4ddd52843'),
      ('district0x', '0xd20e4d854c71de2428e1268167753e4c7070ae68'),
      ('Encrypgen', '3BnvD37EBj9EN89wrruPV44KxpYrYKTfQB'),
      ('Etherisc', '0x9B0F6a5a667CB92aF0cd15DbE90E764e32f69e77'),
      ('Etherisc', '0x35792029777427920ce7aDecccE9e645465e9C72'),
      ('Expanse/Tokenlab', '0xd1ea8853619aaad66f3f6c14ca22430ce6954476'),
      ('Expanse/Tokenlab', '0xf83fd4b62ccb4b5c4213278b6b506eb2f19988d0'),
      ('Indorse', '0x1c82ee5b828455F870eb2998f2c9b6Cc2d52a5F6'),
      ('Indorse', '0x26967201d4d1e1aa97554838defa4fc4d010ff6f'),
      ('Iconomi', '0x154Af3E01eC56Bc55fD585622E33E3dfb8a248d8'),
      ('Hellenium', '0xb3713B791E7b9879fe4C5F2154EcE5eE37a3588b'),
      ('Lalena', '0xbb4e3f5c8b45f0d158d74e3faa42629d791b37cd'),
      ('Maecenas', '0x02DC3b8AB87c562CdCE707647bd1ba21C390Faf4'),
      ('Maecenas', '0x9B60874D7bc4e4fBDd142e0F5a12002e4F7715a6'),
      ('Metal', '0xF433089366899D83a9f26A773D59ec7eCF30355e'),
      ('Musiconomi', '0xc7CD9d874F93F2409F39A95987b3E3C738313925'),
      ('Ohni', '0x0d13A61AAEd844583044b057dDe9FABe9Ea90722'),
      ('Ohni', '0x2276BDc6d9159b19F73E8b395cc69e8Aeb29c86e'),
      ('Ohni', '0xa36e7c76da888237a3fb8a035d971ae179b45fad'),
      ('Santiment', '0x6dd5a9f47cfbc44c04a0a4452f0ba792ebfbcc9a'),
      ('SONM', '0x93025150b13Eb744D51d927549a30630912E8Fe8'),
      ('Status.im', '0xA646E29877d52B9e2De457ECa09C724fF16D0a2B')
    ) AS t (name, address)
  WHERE
    project.name = t.name

ON CONFLICT (address) DO UPDATE
  SET address = EXCLUDED.address;

INSERT INTO project_btc_address (project_id, address)
  SELECT
    project.id,
    t.address
  FROM
    project,
    (VALUES
      ('Encrypgen', '13MoQt2n9cHNzbpt8PfeVYp2cehgzRgj6v'),
      ('Encrypgen', '16bv1XAqh1YadAWHgDWgxKuhhns7T2EywG'),
      ('Encrypgen', '3BnvD37EBj9EN89wrruPV44KxpYrYKTfQB'),
      ('Encrypgen', '3PtQX3dKbUb7Q8LguBrWVcwddf2yCkDJW9'),
      ('Encrypgen', '33TK711ktEUJxERdTtkoE5cTaPVsi3JDya')
    ) AS t (name, address)
  WHERE
    project.name = t.name

ON CONFLICT (address) DO UPDATE
  SET address = EXCLUDED.address;


/* Set known addresses to tracked */

INSERT INTO tracked_eth (address)
  SELECT
    address
  FROM
    project_eth_address
ON CONFLICT DO NOTHING;

INSERT INTO tracked_btc (address)
  SELECT
    address
  FROM
    project_btc_address
ON CONFLICT DO NOTHING;
