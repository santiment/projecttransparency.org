/* Populate database with projecttransparency data */
INSERT INTO project (ticker, name) VALUES
  ('ANT', 'Aragon'),
  /* ('', 'Attores'), */
  ('CFI', 'Cofound.it'),
  ('DAP', 'Dappbase.com'),
  ('DNT', 'district0x'),
  ('DNA', 'Encrypgen'),
  ('RSC', 'Etherisc'),
  ('GAT', 'Gatcoin.io'),
  ('HSR', 'Hshare'),
  ('ICN', 'Iconomi'),
  ('IND', 'Indorse'),
  /* ('', 'IconiqLab'), */
  ('KPMG', 'KPMG'),
  ('LKK', 'Lykke'),
  ('ART', 'Maecenas'),
  ('MCI', 'Musiconomi'),
  ('SAN', 'Santiment'),
  ('SNT', 'Status.im'),
  ('VIC', 'Virgil Capital');

/* Insert known addresses */
INSERT INTO project_eth_address (project_id, address)
  SELECT
    project.id,
    t.address
  FROM
    project,
    (VALUES
      ('Aragon', '0xcafe1a77e84698c83ca8931f54a755176ef75f2c'),
      ('district0x', '0xd20e4d854c71de2428e1268167753e4c7070ae68'),
      ('Encrypgen', '0x683a0aafa039406c104d814b9f244eea721445a7'),
      ('Etherisc', '0x9B0F6a5a667CB92aF0cd15DbE90E764e32f69e77'),
      ('Iconomi', '0x154Af3E01eC56Bc55fD585622E33E3dfb8a248d8'),
      /* ('Indorse', '0x26967201d4d1e1aa97554838defa4fc4d010ff6f'), */
      ('Maecenas', '0x02DC3b8AB87c562CdCE707647bd1ba21C390Faf4'),
      ('Musiconomi', '0xc7CD9d874F93F2409F39A95987b3E3C738313925'),
      ('Santiment', '0x6dd5a9f47cfbc44c04a0a4452f0ba792ebfbcc9a'),
      ('Status.im', '0xA646E29877d52B9e2De457ECa09C724fF16D0a2B'),
      ('Virgil Capital', '0x0D7096819e18D4B096998A1254Db8bbEC72c0c13')
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

  
