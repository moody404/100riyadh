-- Sample seed data for Riyadh restaurants
-- Paste this into Supabase SQL Editor to add example restaurants
-- You can modify the names, links, and vote counts

INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  -- Top rated
  ('Juhayna Modern Cuisine', 'https://www.google.com/maps/search/Juhayna+Riyadh', 150, 'seed_001', 'approved'),
  ('Marjan', 'https://www.google.com/maps/search/Marjan+Riyadh', 145, 'seed_002', 'approved'),
  ('Chakli', 'https://www.google.com/maps/search/Chakli+Riyadh', 140, 'seed_003', 'approved'),
  ('Blue Jasmine', 'https://www.google.com/maps/search/Blue+Jasmine+Riyadh', 135, 'seed_004', 'approved'),
  ('Nobu', 'https://www.google.com/maps/search/Nobu+Riyadh', 130, 'seed_005', 'approved'),

  -- Popular restaurants
  ('Nusr-Et Steakhouse', 'https://www.google.com/maps/search/Nusr-Et+Riyadh', 125, 'seed_006', 'approved'),
  ('Babel', 'https://www.google.com/maps/search/Babel+Riyadh', 120, 'seed_007', 'approved'),
  ('The Avocado', 'https://www.google.com/maps/search/The+Avocado+Riyadh', 115, 'seed_008', 'approved'),
  ('Toro Sushi', 'https://www.google.com/maps/search/Toro+Sushi+Riyadh', 110, 'seed_009', 'approved'),
  ('Dishoom', 'https://www.google.com/maps/search/Dishoom+Riyadh', 105, 'seed_010', 'approved'),

  -- Good options
  ('Carbone', 'https://www.google.com/maps/search/Carbone+Riyadh', 100, 'seed_011', 'approved'),
  ('Matsuri', 'https://www.google.com/maps/search/Matsuri+Riyadh', 95, 'seed_012', 'approved'),
  ('Ministry Of Oud', 'https://www.google.com/maps/search/Ministry+Of+Oud+Riyadh', 90, 'seed_013', 'approved'),
  ('Monza', 'https://www.google.com/maps/search/Monza+Riyadh', 85, 'seed_014', 'approved'),
  ('Sushi Zen', 'https://www.google.com/maps/search/Sushi+Zen+Riyadh', 80, 'seed_015', 'approved'),

  ('Rayya House', 'https://www.google.com/maps/search/Rayya+House+Riyadh', 75, 'seed_016', 'approved'),
  ('Balad Almawada', 'https://www.google.com/maps/search/Balad+Almawada+Riyadh', 70, 'seed_017', 'approved'),
  ('The Noodle House', 'https://www.google.com/maps/search/Noodle+House+Riyadh', 65, 'seed_018', 'approved'),
  ('Al Reef Bakery', 'https://www.google.com/maps/search/Al+Reef+Bakery+Riyadh', 60, 'seed_019', 'approved'),
  ('Herbal Cafe', 'https://www.google.com/maps/search/Herbal+Cafe+Riyadh', 55, 'seed_020', 'approved');

-- You can continue adding more restaurants...
-- Just copy and paste more INSERT statements with different values
