-- ============================================================================
-- COMPLETE SETUP: Create Tables + Import 94 Restaurants
-- ============================================================================
-- Run this entire file in Supabase SQL Editor
-- It will create tables and import all restaurant data
-- ============================================================================

-- Step 1: Create restaurants table
-- ============================================================================
CREATE TABLE IF NOT EXISTS restaurants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name varchar(100) NOT NULL,
  google_link text NOT NULL,
  vote_count integer DEFAULT 1,
  created_by_device_id varchar(100) NOT NULL,
  status varchar(20) DEFAULT 'approved',
  created_at timestamp with time zone DEFAULT now()
);

-- Step 2: Create votes table
-- ============================================================================
CREATE TABLE IF NOT EXISTS votes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  restaurant_id uuid NOT NULL REFERENCES restaurants(id) ON DELETE CASCADE,
  device_id varchar(100) NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  UNIQUE(restaurant_id, device_id)
);

-- Step 3: Create indexes for better performance
-- ============================================================================
CREATE INDEX IF NOT EXISTS idx_restaurants_vote_count ON restaurants(vote_count DESC);
CREATE INDEX IF NOT EXISTS idx_restaurants_created_at ON restaurants(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_votes_device_id ON votes(device_id);
CREATE INDEX IF NOT EXISTS idx_votes_restaurant_id ON votes(restaurant_id);

-- Step 4: Create function to increment restaurant votes
-- ============================================================================
CREATE OR REPLACE FUNCTION increment_restaurant_votes(restaurant_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE restaurants
  SET vote_count = vote_count + 1
  WHERE id = restaurant_id;
END;
$$ LANGUAGE plpgsql;

-- Step 5: Enable Row Level Security
-- ============================================================================
ALTER TABLE restaurants ENABLE ROW LEVEL SECURITY;
ALTER TABLE votes ENABLE ROW LEVEL SECURITY;

-- Step 6: Create RLS policies for restaurants
-- ============================================================================
CREATE POLICY "Allow read all restaurants" ON restaurants
  FOR SELECT USING (true);

CREATE POLICY "Allow insert restaurants" ON restaurants
  FOR INSERT WITH CHECK (true);

-- Step 7: Create RLS policies for votes
-- ============================================================================
CREATE POLICY "Allow read all votes" ON votes
  FOR SELECT USING (true);

CREATE POLICY "Allow insert votes" ON votes
  FOR INSERT WITH CHECK (true);

-- Step 8: Enable realtime
-- ============================================================================
ALTER PUBLICATION supabase_realtime ADD TABLE restaurants;
ALTER PUBLICATION supabase_realtime ADD TABLE votes;

-- ============================================================================
-- NOW INSERT ALL 94 RESTAURANTS
-- ============================================================================

-- Category 1: Saudi Cuisine (19 restaurants)
INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  ('Al Romansiah', 'https://www.google.com/maps/search/Al+Romansiah+Riyadh', 175, 'seed_saudi_001', 'approved'),
  ('Shawarma House', 'https://www.google.com/maps/search/Shawarma+House+Riyadh', 180, 'seed_saudi_002', 'approved'),
  ('Najd Village', 'https://www.google.com/maps/search/Najd+Village+Riyadh', 145, 'seed_saudi_003', 'approved'),
  ('Tameesa', 'https://www.google.com/maps/search/Tameesa+Riyadh', 155, 'seed_saudi_004', 'approved'),
  ('Mama Noura', 'https://www.google.com/maps/search/Mama+Noura+Riyadh', 170, 'seed_saudi_005', 'approved'),
  ('Suhail', 'https://www.google.com/maps/search/Suhail+Modern+Saudi+Riyadh', 120, 'seed_saudi_006', 'approved'),
  ('Al-Saj Al-Reefi', 'https://www.google.com/maps/search/Al-Saj+Al-Reefi+Riyadh', 95, 'seed_saudi_007', 'approved'),
  ('Shwaiat Al Khalij', 'https://www.google.com/maps/search/Shwaiat+Al+Khalij+Riyadh', 165, 'seed_saudi_008', 'approved'),
  ('Tebsi', 'https://www.google.com/maps/search/Tebsi+Riyadh', 140, 'seed_saudi_009', 'approved'),
  ('Al Nadeg', 'https://www.google.com/maps/search/Al+Nadeg+Riyadh', 130, 'seed_saudi_010', 'approved'),
  ('Aseeb', 'https://www.google.com/maps/search/Aseeb+Alyasmin+Riyadh', 195, 'seed_saudi_011', 'approved'),
  ('Mirzam', 'https://www.google.com/maps/search/Mirzam+An+Nakheel+Riyadh', 160, 'seed_saudi_012', 'approved'),
  ('Maiz', 'https://www.google.com/maps/search/Maiz+Bujairi+Diriyah', 175, 'seed_saudi_013', 'approved'),
  ('Tofareya', 'https://www.google.com/maps/search/Tofareya+Al+Malqa+Riyadh', 135, 'seed_saudi_014', 'approved'),
  ('Takya', 'https://www.google.com/maps/search/Takya+Bujairi+Diriyah', 155, 'seed_saudi_015', 'approved'),
  ('Taleed by Michael Mina', 'https://www.google.com/maps/search/Taleed+by+Michael+Mina+Diriyah', 185, 'seed_saudi_016', 'approved'),
  ('Botanica', 'https://www.google.com/maps/search/Botanica+KAFD+Riyadh', 125, 'seed_saudi_017', 'approved'),
  ('Fi Glbak', 'https://www.google.com/maps/search/Fi+Glbak+Riyadh', 110, 'seed_saudi_018', 'approved'),
  ('Hamsa W Taghmeesa', 'https://www.google.com/maps/search/Hamsa+W+Taghmeesa+Riyadh', 115, 'seed_saudi_019', 'approved');

-- Category 2: Japanese Cuisine (18 restaurants)
INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  ('Myazu', 'https://www.google.com/maps/search/Myazu+As+Sulimaniyah+Riyadh', 210, 'seed_japanese_001', 'approved'),
  ('Nozomi', 'https://www.google.com/maps/search/Nozomi+Al+Olaya+Riyadh', 155, 'seed_japanese_002', 'approved'),
  ('ROKA', 'https://www.google.com/maps/search/ROKA+As+Sulimaniyah+Riyadh', 145, 'seed_japanese_003', 'approved'),
  ('KAYZŌ', 'https://www.google.com/maps/search/KAYZO+As+Sulimaniyah+Riyadh', 150, 'seed_japanese_004', 'approved'),
  ('Kintan', 'https://www.google.com/maps/search/Kintan+Yakiniku+Riyadh', 140, 'seed_japanese_005', 'approved'),
  ('CLAP', 'https://www.google.com/maps/search/CLAP+Ramla+Terraza+Riyadh', 120, 'seed_japanese_006', 'approved'),
  ('Tokyo', 'https://www.google.com/maps/search/Tokyo+As+Sulimaniyah+Riyadh', 125, 'seed_japanese_007', 'approved'),
  ('Yokari', 'https://www.google.com/maps/search/Yokari+Al+Olaya+Riyadh', 115, 'seed_japanese_008', 'approved'),
  ('Gold Sushi Club', 'https://www.google.com/maps/search/Gold+Sushi+Club+Riyadh', 135, 'seed_japanese_009', 'approved'),
  ('Sushih', 'https://www.google.com/maps/search/Sushih+Al+Olaya+Riyadh', 110, 'seed_japanese_010', 'approved'),
  ('Kuuru', 'https://www.google.com/maps/search/Kuuru+KAFD+Riyadh', 200, 'seed_japanese_011', 'approved'),
  ('Hōchō', 'https://www.google.com/maps/search/Hocho+Via+Riyadh+Riyadh', 170, 'seed_japanese_012', 'approved'),
  ('Robata', 'https://www.google.com/maps/search/Robata+Hittin+Riyadh', 160, 'seed_japanese_013', 'approved'),
  ('Chotto Matte', 'https://www.google.com/maps/search/Chotto+Matte+KAFD+Riyadh', 130, 'seed_japanese_014', 'approved'),
  ('Akira Back', 'https://www.google.com/maps/search/Akira+Back+Diplomatic+Quarter', 185, 'seed_japanese_015', 'approved'),
  ('Teruzushi', 'https://www.google.com/maps/search/Teruzushi+Via+Riyadh+Riyadh', 125, 'seed_japanese_016', 'approved'),
  ('Sumosan', 'https://www.google.com/maps/search/Sumosan+Laysen+Valley+Riyadh', 140, 'seed_japanese_017', 'approved'),
  ('EDO restaurant', 'https://www.google.com/maps/search/EDO+As+Siddiq+Road+Riyadh', 105, 'seed_japanese_018', 'approved');

-- Category 3: Italian Cuisine (12 restaurants)
INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  ('Mamo Michelangelo', 'https://www.google.com/maps/search/Mamo+Michelangelo+Al+Olaya', 155, 'seed_italian_001', 'approved'),
  ('San Carlo Cicchetti', 'https://www.google.com/maps/search/San+Carlo+Cicchetti+As+Sulimaniyah', 150, 'seed_italian_002', 'approved'),
  ('Carbone', 'https://www.google.com/maps/search/Carbone+Mansard+Riyadh', 190, 'seed_italian_003', 'approved'),
  ('Cipriani', 'https://www.google.com/maps/search/Cipriani+Bujairi+Terrace', 185, 'seed_italian_004', 'approved'),
  ('Il Baretto', 'https://www.google.com/maps/search/Il+Baretto+KAFD+Riyadh', 195, 'seed_italian_005', 'approved'),
  ('The Social Pizzeria', 'https://www.google.com/maps/search/The+Social+Pizzeria+Ar+Rabwah', 135, 'seed_italian_006', 'approved'),
  ('Blanca Pizzeria', 'https://www.google.com/maps/search/Blanca+Pizzeria+As+Sulimaniyah', 145, 'seed_italian_007', 'approved'),
  ('Jon & Vinny''s', 'https://www.google.com/maps/search/Jon+and+Vinnys+As+Sulimaniyah', 140, 'seed_italian_008', 'approved'),
  ('Agio', 'https://www.google.com/maps/search/Agio+Italian+Riyadh', 120, 'seed_italian_009', 'approved'),
  ('Pastamamma', 'https://www.google.com/maps/search/Pastamamma+Riyadh+Park+Mall', 130, 'seed_italian_010', 'approved'),
  ('Fiamma', 'https://www.google.com/maps/search/Fiamma+Centria+Mall+Riyadh', 125, 'seed_italian_011', 'approved'),
  ('Cipriani Dolci', 'https://www.google.com/maps/search/Cipriani+Dolci+Diplomatic+Quarter', 115, 'seed_italian_012', 'approved');

-- Category 4: American Cuisine (15 restaurants)
INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  ('Section-B', 'https://www.google.com/maps/search/Section-B+Hittin+Riyadh', 175, 'seed_american_001', 'approved'),
  ('Marble', 'https://www.google.com/maps/search/Marble+Turki+Square+Riyadh', 200, 'seed_american_002', 'approved'),
  ('Smokey Beards Q', 'https://www.google.com/maps/search/Smokey+Beards+Q+Hittin', 185, 'seed_american_003', 'approved'),
  ('Chef''s Smokehouse', 'https://www.google.com/maps/search/Chefs+Smokehouse+Riyadh', 155, 'seed_american_004', 'approved'),
  ('Porterhouse', 'https://www.google.com/maps/search/Porterhouse+Al+Olaya+Riyadh', 150, 'seed_american_005', 'approved'),
  ('Black Tap', 'https://www.google.com/maps/search/Black+Tap+KAFD+Riyadh', 135, 'seed_american_006', 'approved'),
  ('Burger Boutique', 'https://www.google.com/maps/search/Burger+Boutique+Al+Olaya', 130, 'seed_american_007', 'approved'),
  ('Pickl', 'https://www.google.com/maps/search/Pickl+U+Walk+Riyadh', 140, 'seed_american_008', 'approved'),
  ('Nashville''s', 'https://www.google.com/maps/search/Nashvilles+Fried+Chicken+Riyadh', 145, 'seed_american_009', 'approved'),
  ('California Burger', 'https://www.google.com/maps/search/California+Burger+Riyadh', 125, 'seed_american_010', 'approved'),
  ('Beefbar', 'https://www.google.com/maps/search/Beefbar+As+Sulimaniyah', 180, 'seed_american_011', 'approved'),
  ('COYA', 'https://www.google.com/maps/search/COYA+As+Sulimaniyah+Riyadh', 160, 'seed_american_012', 'approved'),
  ('AB Steak by Chef Akira Back', 'https://www.google.com/maps/search/AB+Steak+Diplomatic+Quarter', 175, 'seed_american_013', 'approved'),
  ('Supernova', 'https://www.google.com/maps/search/Supernova+Al+Nakheel+Riyadh', 120, 'seed_american_014', 'approved'),
  ('Nora Smashed Burgers', 'https://www.google.com/maps/search/Nora+Smashed+Burgers+Al+Malqa', 115, 'seed_american_015', 'approved');

-- Category 5: Indian Cuisine (10 restaurants)
INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  ('Gymkhana', 'https://www.google.com/maps/search/Gymkhana+Via+Riyadh+Riyadh', 195, 'seed_indian_001', 'approved'),
  ('Kumar', 'https://www.google.com/maps/search/Kumar+Riyadh+Park+Riyadh', 150, 'seed_indian_002', 'approved'),
  ('Ruhi', 'https://www.google.com/maps/search/Ruhi+KAFD+Riyadh', 160, 'seed_indian_003', 'approved'),
  ('Lunch Room', 'https://www.google.com/maps/search/Lunch+Room+Pure+Centre+Riyadh', 165, 'seed_indian_004', 'approved'),
  ('Indian Corner', 'https://www.google.com/maps/search/Indian+Corner+Riyadh', 115, 'seed_indian_005', 'approved'),
  ('Lahori Khabay', 'https://www.google.com/maps/search/Lahori+Khabay+Riyadh', 120, 'seed_indian_006', 'approved'),
  ('Bawarchi Restaurant', 'https://www.google.com/maps/search/Bawarchi+Restaurant+Riyadh', 125, 'seed_indian_007', 'approved'),
  ('Yauatcha', 'https://www.google.com/maps/search/Yauatcha+Al+Olaya+Riyadh', 155, 'seed_indian_008', 'approved'),
  ('Zafran Indian Bistro', 'https://www.google.com/maps/search/Zafran+Indian+Bistro+Riyadh', 110, 'seed_indian_009', 'approved'),
  ('Mohalla', 'https://www.google.com/maps/search/Mohalla+The+Esplanade+Riyadh', 135, 'seed_indian_010', 'approved');

-- Category 6: French Cuisine (12 restaurants)
INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  ('LPM Restaurant & Café', 'https://www.google.com/maps/search/LPM+Restaurant+Al+Olaya', 185, 'seed_french_001', 'approved'),
  ('Bagatelle', 'https://www.google.com/maps/search/Bagatelle+Laysen+Valley+Riyadh', 180, 'seed_french_002', 'approved'),
  ('Benoit by Alain Ducasse', 'https://www.google.com/maps/search/Benoit+by+Alain+Ducasse+KAFD', 190, 'seed_french_003', 'approved'),
  ('Café Boulud', 'https://www.google.com/maps/search/Cafe+Boulud+Four+Seasons+Riyadh', 175, 'seed_french_004', 'approved'),
  ('L''ami Dave', 'https://www.google.com/maps/search/Lami+Dave+Mansard+Riyadh', 160, 'seed_french_005', 'approved'),
  ('ferdi', 'https://www.google.com/maps/search/ferdi+Via+Riyadh+Riyadh', 170, 'seed_french_006', 'approved'),
  ('Les Deux Magots', 'https://www.google.com/maps/search/Les+Deux+Magots+Via+Riyadh', 165, 'seed_french_007', 'approved'),
  ('Café de L''Esplanade', 'https://www.google.com/maps/search/Cafe+de+LEsplanade+Bujairi', 145, 'seed_french_008', 'approved'),
  ('Lenôtre', 'https://www.google.com/maps/search/Lenotre+Centria+Mall+Riyadh', 135, 'seed_french_009', 'approved'),
  ('PAUL', 'https://www.google.com/maps/search/PAUL+Bakery+Riyadh', 120, 'seed_french_010', 'approved'),
  ('La Maison Ani', 'https://www.google.com/maps/search/La+Maison+Ani+Riyadh', 155, 'seed_french_011', 'approved'),
  ('Café L''Occitane', 'https://www.google.com/maps/search/Cafe+LOccitane+Diplomatic+Quarter', 125, 'seed_french_012', 'approved');

-- Category 7: Lebanese & Middle Eastern Cuisine (14 restaurants)
INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  ('Lusin', 'https://www.google.com/maps/search/Lusin+Centria+Mall+Riyadh', 175, 'seed_middle_east_001', 'approved'),
  ('Em Sherif Café', 'https://www.google.com/maps/search/Em+Sherif+Cafe+Riyadh', 195, 'seed_middle_east_002', 'approved'),
  ('Burj Al Hamam', 'https://www.google.com/maps/search/Burj+Al+Hamam+Al+Takhassousi', 160, 'seed_middle_east_003', 'approved'),
  ('Villa Fayrouz', 'https://www.google.com/maps/search/Villa+Fayrouz+Al+Olaya+Riyadh', 155, 'seed_middle_east_004', 'approved'),
  ('Shababïk', 'https://www.google.com/maps/search/Shababik+As+Sulimaniyah+Riyadh', 150, 'seed_middle_east_005', 'approved'),
  ('Leila Min Lebnen', 'https://www.google.com/maps/search/Leila+Min+Lebnen+Al+Safarat', 125, 'seed_middle_east_006', 'approved'),
  ('Bayader Al Quds', 'https://www.google.com/maps/search/Bayader+Al+Quds+Riyadh', 115, 'seed_middle_east_007', 'approved'),
  ('Al-Nafoura Restaurant', 'https://www.google.com/maps/search/Al-Nafoura+Restaurant+Namar', 120, 'seed_middle_east_008', 'approved'),
  ('Rüya', 'https://www.google.com/maps/search/Ruya+As+Sulimaniyah+Riyadh', 200, 'seed_middle_east_009', 'approved'),
  ('Alaya', 'https://www.google.com/maps/search/Alaya+Riyadh', 140, 'seed_middle_east_010', 'approved'),
  ('Al Falamanki', 'https://www.google.com/maps/search/Al+Falamanki+Al+Malga+Riyadh', 130, 'seed_middle_east_011', 'approved'),
  ('Em Sherif Sea Cafe', 'https://www.google.com/maps/search/Em+Sherif+Sea+Cafe+Laysen+Valley', 145, 'seed_middle_east_012', 'approved'),
  ('Beirut Khanum', 'https://www.google.com/maps/search/Beirut+Khanum+Hittin+Riyadh', 135, 'seed_middle_east_013', 'approved'),
  ('MLLe', 'https://www.google.com/maps/search/MLLe+Laysen+Valley+Riyadh', 140, 'seed_middle_east_014', 'approved');

-- ============================================================================
-- VERIFICATION: Show what was created
-- ============================================================================
SELECT 'Tables and data created successfully!' as status;
SELECT COUNT(*) as total_restaurants FROM restaurants;
SELECT name, vote_count FROM restaurants ORDER BY vote_count DESC LIMIT 10;
