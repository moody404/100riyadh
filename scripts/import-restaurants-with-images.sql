-- ============================================================================
-- IMPORT 94 RESTAURANTS WITH IMAGES AND BEST DISHES
-- ============================================================================
-- Run this file to import all restaurant data with diverse images
-- Make sure to run add-best-dish-field.sql first
-- ============================================================================

-- Category 1: Saudi Cuisine (19 restaurants)
INSERT INTO restaurants (name, google_link, image_url, best_dish, vote_count, created_by_device_id, status)
VALUES
  ('Al Romansiah', 'https://www.google.com/maps/search/Al+Romansiah+Riyadh', 'https://images.unsplash.com/photo-1603360946369-dc9bb6258143?w=800&q=80', 'Kabsa with Lamb', 175, 'seed_saudi_001', 'approved'),
  ('Shawarma House', 'https://www.google.com/maps/search/Shawarma+House+Riyadh', 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800&q=80', 'Chicken Shawarma Wrap', 180, 'seed_saudi_002', 'approved'),
  ('Najd Village', 'https://www.google.com/maps/search/Najd+Village+Riyadh', 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80', 'Mathbi Chicken', 145, 'seed_saudi_003', 'approved'),
  ('Tameesa', 'https://www.google.com/maps/search/Tameesa+Riyadh', 'https://images.unsplash.com/photo-1583394293214-28ded15ee548?w=800&q=80', 'Jareesh', 155, 'seed_saudi_004', 'approved'),
  ('Mama Noura', 'https://www.google.com/maps/search/Mama+Noura+Riyadh', 'https://images.unsplash.com/photo-1567337710282-00832b415979?w=800&q=80', 'Mutabbaq', 170, 'seed_saudi_005', 'approved'),
  ('Suhail', 'https://www.google.com/maps/search/Suhail+Modern+Saudi+Riyadh', 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=800&q=80', 'Modern Kabsa Bowl', 120, 'seed_saudi_006', 'approved'),
  ('Al-Saj Al-Reefi', 'https://www.google.com/maps/search/Al-Saj+Al-Reefi+Riyadh', 'https://images.unsplash.com/photo-1585518419759-7fe2e0fbf8a6?w=800&q=80', 'Fatayer Saj', 95, 'seed_saudi_007', 'approved'),
  ('Shwaiat Al Khalij', 'https://www.google.com/maps/search/Shwaiat+Al+Khalij+Riyadh', 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800&q=80', 'Grilled Lamb Chops', 165, 'seed_saudi_008', 'approved'),
  ('Tebsi', 'https://www.google.com/maps/search/Tebsi+Riyadh', 'https://images.unsplash.com/photo-1574484284002-952d92456975?w=800&q=80', 'Chicken Tebsi', 140, 'seed_saudi_009', 'approved'),
  ('Al Nadeg', 'https://www.google.com/maps/search/Al+Nadeg+Riyadh', 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&q=80', 'Chicken Nuggets', 130, 'seed_saudi_010', 'approved'),
  ('Aseeb', 'https://www.google.com/maps/search/Aseeb+Alyasmin+Riyadh', 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800&q=80', 'Lamb Ouzi', 195, 'seed_saudi_011', 'approved'),
  ('Mirzam', 'https://www.google.com/maps/search/Mirzam+An+Nakheel+Riyadh', 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=800&q=80', 'Seafood Sayadieh', 160, 'seed_saudi_012', 'approved'),
  ('Maiz', 'https://www.google.com/maps/search/Maiz+Bujairi+Diriyah', 'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=800&q=80', 'Heritage Kabsa', 175, 'seed_saudi_013', 'approved'),
  ('Tofareya', 'https://www.google.com/maps/search/Tofareya+Al+Malqa+Riyadh', 'https://images.unsplash.com/photo-1542528180-1c2803fa048c?w=800&q=80', 'Lamb Mandi', 135, 'seed_saudi_014', 'approved'),
  ('Takya', 'https://www.google.com/maps/search/Takya+Bujairi+Diriyah', 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&q=80', 'Grilled Meat Platter', 155, 'seed_saudi_015', 'approved'),
  ('Taleed by Michael Mina', 'https://www.google.com/maps/search/Taleed+by+Michael+Mina+Diriyah', 'https://images.unsplash.com/photo-1560624052-449f5ddf0c31?w=800&q=80', 'Wagyu Kabsa', 185, 'seed_saudi_016', 'approved'),
  ('Botanica', 'https://www.google.com/maps/search/Botanica+KAFD+Riyadh', 'https://images.unsplash.com/photo-1540914124281-342587941389?w=800&q=80', 'Truffle Hummus', 125, 'seed_saudi_017', 'approved'),
  ('Fi Glbak', 'https://www.google.com/maps/search/Fi+Glbak+Riyadh', 'https://images.unsplash.com/photo-1606787364406-a3cdb7c0b32c?w=800&q=80', 'Cheese Manakish', 110, 'seed_saudi_018', 'approved'),
  ('Hamsa W Taghmeesa', 'https://www.google.com/maps/search/Hamsa+W+Taghmeesa+Riyadh', 'https://images.unsplash.com/photo-1619221882181-50fd7f3e2e62?w=800&q=80', 'Fried Chicken Strips', 115, 'seed_saudi_019', 'approved');

-- Category 2: Japanese Cuisine (18 restaurants)
INSERT INTO restaurants (name, google_link, image_url, best_dish, vote_count, created_by_device_id, status)
VALUES
  ('Myazu', 'https://www.google.com/maps/search/Myazu+As+Sulimaniyah+Riyadh', 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&q=80', 'Omakase Sushi', 210, 'seed_japanese_001', 'approved'),
  ('Nozomi', 'https://www.google.com/maps/search/Nozomi+Al+Olaya+Riyadh', 'https://images.unsplash.com/photo-1564489563601-c53cfc451e93?w=800&q=80', 'Black Cod Miso', 155, 'seed_japanese_002', 'approved'),
  ('ROKA', 'https://www.google.com/maps/search/ROKA+As+Sulimaniyah+Riyadh', 'https://images.unsplash.com/photo-1611143669185-af224c5e3252?w=800&q=80', 'Wagyu Beef Tataki', 145, 'seed_japanese_003', 'approved'),
  ('KAYZŌ', 'https://www.google.com/maps/search/KAYZO+As+Sulimaniyah+Riyadh', 'https://images.unsplash.com/photo-1563612116625-3012372fccce?w=800&q=80', 'Truffle Salmon Roll', 150, 'seed_japanese_004', 'approved'),
  ('Kintan', 'https://www.google.com/maps/search/Kintan+Yakiniku+Riyadh', 'https://images.unsplash.com/photo-1621924229512-e25cf4bc3b48?w=800&q=80', 'Premium Yakiniku Set', 140, 'seed_japanese_005', 'approved'),
  ('CLAP', 'https://www.google.com/maps/search/CLAP+Ramla+Terraza+Riyadh', 'https://images.unsplash.com/photo-1580822184713-fc5400e7fe10?w=800&q=80', 'Dragon Roll', 120, 'seed_japanese_006', 'approved'),
  ('Tokyo', 'https://www.google.com/maps/search/Tokyo+As+Sulimaniyah+Riyadh', 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800&q=80', 'Chirashi Bowl', 125, 'seed_japanese_007', 'approved'),
  ('Yokari', 'https://www.google.com/maps/search/Yokari+Al+Olaya+Riyadh', 'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=800&q=80', 'Wagyu Donburi', 115, 'seed_japanese_008', 'approved'),
  ('Gold Sushi Club', 'https://www.google.com/maps/search/Gold+Sushi+Club+Riyadh', 'https://images.unsplash.com/photo-1615361200098-613c2985de0d?w=800&q=80', 'Gold Leaf Sushi', 135, 'seed_japanese_009', 'approved'),
  ('Sushih', 'https://www.google.com/maps/search/Sushih+Al+Olaya+Riyadh', 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&q=80', 'Salmon Sashimi', 110, 'seed_japanese_010', 'approved'),
  ('Kuuru', 'https://www.google.com/maps/search/Kuuru+KAFD+Riyadh', 'https://images.unsplash.com/photo-1599084993091-1cb5c0721cc6?w=800&q=80', 'Toro Nigiri', 200, 'seed_japanese_011', 'approved'),
  ('Hōchō', 'https://www.google.com/maps/search/Hocho+Via+Riyadh+Riyadh', 'https://images.unsplash.com/photo-1583623025817-d180a2221d0a?w=800&q=80', 'Chef Special Roll', 170, 'seed_japanese_012', 'approved'),
  ('Robata', 'https://www.google.com/maps/search/Robata+Hittin+Riyadh', 'https://images.unsplash.com/photo-1594834801881-c0b1f6d315d7?w=800&q=80', 'Grilled Scallops', 160, 'seed_japanese_013', 'approved'),
  ('Chotto Matte', 'https://www.google.com/maps/search/Chotto+Matte+KAFD+Riyadh', 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&q=80', 'Nikkei Maki', 130, 'seed_japanese_014', 'approved'),
  ('Akira Back', 'https://www.google.com/maps/search/Akira+Back+Diplomatic+Quarter', 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=800&q=80', 'AB Tuna Pizza', 185, 'seed_japanese_015', 'approved'),
  ('Teruzushi', 'https://www.google.com/maps/search/Teruzushi+Via+Riyadh+Riyadh', 'https://images.unsplash.com/photo-1559825481-12a05cc00344?w=800&q=80', 'Edomae Sushi', 125, 'seed_japanese_016', 'approved'),
  ('Sumosan', 'https://www.google.com/maps/search/Sumosan+Laysen+Valley+Riyadh', 'https://images.unsplash.com/photo-1582450871972-ab5ca641643d?w=800&q=80', 'Lobster Tempura', 140, 'seed_japanese_017', 'approved'),
  ('EDO restaurant', 'https://www.google.com/maps/search/EDO+As+Siddiq+Road+Riyadh', 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&q=80', 'Ramen Bowl', 105, 'seed_japanese_018', 'approved');

-- Category 3: Italian Cuisine (12 restaurants)
INSERT INTO restaurants (name, google_link, image_url, best_dish, vote_count, created_by_device_id, status)
VALUES
  ('Mamo Michelangelo', 'https://www.google.com/maps/search/Mamo+Michelangelo+Al+Olaya', 'https://images.unsplash.com/photo-1572441713132-c542fc4fe282?w=800&q=80', 'Truffle Pasta', 155, 'seed_italian_001', 'approved'),
  ('San Carlo Cicchetti', 'https://www.google.com/maps/search/San+Carlo+Cicchetti+As+Sulimaniyah', 'https://images.unsplash.com/photo-1608897013039-887f21d8c804?w=800&q=80', 'Venetian Cicchetti', 150, 'seed_italian_002', 'approved'),
  ('Carbone', 'https://www.google.com/maps/search/Carbone+Mansard+Riyadh', 'https://images.unsplash.com/photo-1595295333158-4742f28fbd85?w=800&q=80', 'Spicy Rigatoni', 190, 'seed_italian_003', 'approved'),
  ('Cipriani', 'https://www.google.com/maps/search/Cipriani+Bujairi+Terrace', 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800&q=80', 'Bellini & Carpaccio', 185, 'seed_italian_004', 'approved'),
  ('Il Baretto', 'https://www.google.com/maps/search/Il+Baretto+KAFD+Riyadh', 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&q=80', 'Burrata Pizza', 195, 'seed_italian_005', 'approved'),
  ('The Social Pizzeria', 'https://www.google.com/maps/search/The+Social+Pizzeria+Ar+Rabwah', 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800&q=80', 'Margherita Pizza', 135, 'seed_italian_006', 'approved'),
  ('Blanca Pizzeria', 'https://www.google.com/maps/search/Blanca+Pizzeria+As+Sulimaniyah', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&q=80', 'White Truffle Pizza', 145, 'seed_italian_007', 'approved'),
  ('Jon & Vinny''s', 'https://www.google.com/maps/search/Jon+and+Vinnys+As+Sulimaniyah', 'https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?w=800&q=80', 'Pepperoni Pizza', 140, 'seed_italian_008', 'approved'),
  ('Agio', 'https://www.google.com/maps/search/Agio+Italian+Riyadh', 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=800&q=80', 'Carbonara', 120, 'seed_italian_009', 'approved'),
  ('Pastamamma', 'https://www.google.com/maps/search/Pastamamma+Riyadh+Park+Mall', 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800&q=80', 'Penne Arrabbiata', 130, 'seed_italian_010', 'approved'),
  ('Fiamma', 'https://www.google.com/maps/search/Fiamma+Centria+Mall+Riyadh', 'https://images.unsplash.com/photo-1588013273468-315fd88ea34c?w=800&q=80', 'Osso Buco', 125, 'seed_italian_011', 'approved'),
  ('Cipriani Dolci', 'https://www.google.com/maps/search/Cipriani+Dolci+Diplomatic+Quarter', 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800&q=80', 'Tiramisu', 115, 'seed_italian_012', 'approved');

-- Category 4: American Cuisine (15 restaurants)
INSERT INTO restaurants (name, google_link, image_url, best_dish, vote_count, created_by_device_id, status)
VALUES
  ('Section-B', 'https://www.google.com/maps/search/Section-B+Hittin+Riyadh', 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800&q=80', 'Wagyu Burger', 175, 'seed_american_001', 'approved'),
  ('Marble', 'https://www.google.com/maps/search/Marble+Turki+Square+Riyadh', 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800&q=80', 'Tomahawk Steak', 200, 'seed_american_002', 'approved'),
  ('Smokey Beards Q', 'https://www.google.com/maps/search/Smokey+Beards+Q+Hittin', 'https://images.unsplash.com/photo-1529193591184-b1d58069ecdd?w=800&q=80', 'BBQ Brisket', 185, 'seed_american_003', 'approved'),
  ('Chef''s Smokehouse', 'https://www.google.com/maps/search/Chefs+Smokehouse+Riyadh', 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&q=80', 'Smoked Ribs', 155, 'seed_american_004', 'approved'),
  ('Porterhouse', 'https://www.google.com/maps/search/Porterhouse+Al+Olaya+Riyadh', 'https://images.unsplash.com/photo-1558030006-450675393462?w=800&q=80', 'Porterhouse Steak', 150, 'seed_american_005', 'approved'),
  ('Black Tap', 'https://www.google.com/maps/search/Black+Tap+KAFD+Riyadh', 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=800&q=80', 'Crazy Shake', 135, 'seed_american_006', 'approved'),
  ('Burger Boutique', 'https://www.google.com/maps/search/Burger+Boutique+Al+Olaya', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800&q=80', 'Classic Cheeseburger', 130, 'seed_american_007', 'approved'),
  ('Pickl', 'https://www.google.com/maps/search/Pickl+U+Walk+Riyadh', 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=800&q=80', 'Smash Burger', 140, 'seed_american_008', 'approved'),
  ('Nashville''s', 'https://www.google.com/maps/search/Nashvilles+Fried+Chicken+Riyadh', 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800&q=80', 'Hot Chicken Sandwich', 145, 'seed_american_009', 'approved'),
  ('California Burger', 'https://www.google.com/maps/search/California+Burger+Riyadh', 'https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=800&q=80', 'Double Bacon Burger', 125, 'seed_american_010', 'approved'),
  ('Beefbar', 'https://www.google.com/maps/search/Beefbar+As+Sulimaniyah', 'https://images.unsplash.com/photo-1603360946369-dc9bb6258143?w=800&q=80', 'Wagyu Ribeye', 180, 'seed_american_011', 'approved'),
  ('COYA', 'https://www.google.com/maps/search/COYA+As+Sulimaniyah+Riyadh', 'https://images.unsplash.com/photo-1624300629298-e9de39c13be5?w=800&q=80', 'Ceviche Mixto', 160, 'seed_american_012', 'approved'),
  ('AB Steak by Chef Akira Back', 'https://www.google.com/maps/search/AB+Steak+Diplomatic+Quarter', 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80', 'AB Signature Steak', 175, 'seed_american_013', 'approved'),
  ('Supernova', 'https://www.google.com/maps/search/Supernova+Al+Nakheel+Riyadh', 'https://images.unsplash.com/photo-1551782450-17144efb9c50?w=800&q=80', 'Truffle Fries', 120, 'seed_american_014', 'approved'),
  ('Nora Smashed Burgers', 'https://www.google.com/maps/search/Nora+Smashed+Burgers+Al+Malqa', 'https://images.unsplash.com/photo-1572448862527-d3c904757de6?w=800&q=80', 'Triple Smash Burger', 115, 'seed_american_015', 'approved');

-- Category 5: Indian Cuisine (10 restaurants)
INSERT INTO restaurants (name, google_link, image_url, best_dish, vote_count, created_by_device_id, status)
VALUES
  ('Gymkhana', 'https://www.google.com/maps/search/Gymkhana+Via+Riyadh+Riyadh', 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800&q=80', 'Butter Chicken', 195, 'seed_indian_001', 'approved'),
  ('Kumar', 'https://www.google.com/maps/search/Kumar+Riyadh+Park+Riyadh', 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&q=80', 'Biryani', 150, 'seed_indian_002', 'approved'),
  ('Ruhi', 'https://www.google.com/maps/search/Ruhi+KAFD+Riyadh', 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=800&q=80', 'Tandoori Platter', 160, 'seed_indian_003', 'approved'),
  ('Lunch Room', 'https://www.google.com/maps/search/Lunch+Room+Pure+Centre+Riyadh', 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=800&q=80', 'Dal Makhani', 165, 'seed_indian_004', 'approved'),
  ('Indian Corner', 'https://www.google.com/maps/search/Indian+Corner+Riyadh', 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800&q=80', 'Chicken Tikka Masala', 115, 'seed_indian_005', 'approved'),
  ('Lahori Khabay', 'https://www.google.com/maps/search/Lahori+Khabay+Riyadh', 'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=800&q=80', 'Lahori Karahi', 120, 'seed_indian_006', 'approved'),
  ('Bawarchi Restaurant', 'https://www.google.com/maps/search/Bawarchi+Restaurant+Riyadh', 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=800&q=80', 'Hyderabadi Biryani', 125, 'seed_indian_007', 'approved'),
  ('Yauatcha', 'https://www.google.com/maps/search/Yauatcha+Al+Olaya+Riyadh', 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?w=800&q=80', 'Dim Sum Selection', 155, 'seed_indian_008', 'approved'),
  ('Zafran Indian Bistro', 'https://www.google.com/maps/search/Zafran+Indian+Bistro+Riyadh', 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=800&q=80', 'Rogan Josh', 110, 'seed_indian_009', 'approved'),
  ('Mohalla', 'https://www.google.com/maps/search/Mohalla+The+Esplanade+Riyadh', 'https://images.unsplash.com/photo-1574653853027-23fbb86ba29b?w=800&q=80', 'Street Style Chaat', 135, 'seed_indian_010', 'approved');

-- Category 6: French Cuisine (12 restaurants)
INSERT INTO restaurants (name, google_link, image_url, best_dish, vote_count, created_by_device_id, status)
VALUES
  ('LPM Restaurant & Café', 'https://www.google.com/maps/search/LPM+Restaurant+Al+Olaya', 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800&q=80', 'Bouillabaisse', 185, 'seed_french_001', 'approved'),
  ('Bagatelle', 'https://www.google.com/maps/search/Bagatelle+Laysen+Valley+Riyadh', 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800&q=80', 'Steak Frites', 180, 'seed_french_002', 'approved'),
  ('Benoit by Alain Ducasse', 'https://www.google.com/maps/search/Benoit+by+Alain+Ducasse+KAFD', 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=800&q=80', 'Coq au Vin', 190, 'seed_french_003', 'approved'),
  ('Café Boulud', 'https://www.google.com/maps/search/Cafe+Boulud+Four+Seasons+Riyadh', 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800&q=80', 'Duck Confit', 175, 'seed_french_004', 'approved'),
  ('L''ami Dave', 'https://www.google.com/maps/search/Lami+Dave+Mansard+Riyadh', 'https://images.unsplash.com/photo-1587743425484-05f49c193995?w=800&q=80', 'Escargots', 160, 'seed_french_005', 'approved'),
  ('ferdi', 'https://www.google.com/maps/search/ferdi+Via+Riyadh+Riyadh', 'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=800&q=80', 'Cheeseburger', 170, 'seed_french_006', 'approved'),
  ('Les Deux Magots', 'https://www.google.com/maps/search/Les+Deux+Magots+Via+Riyadh', 'https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?w=800&q=80', 'Croque Monsieur', 165, 'seed_french_007', 'approved'),
  ('Café de L''Esplanade', 'https://www.google.com/maps/search/Cafe+de+LEsplanade+Bujairi', 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&q=80', 'French Onion Soup', 145, 'seed_french_008', 'approved'),
  ('Lenôtre', 'https://www.google.com/maps/search/Lenotre+Centria+Mall+Riyadh', 'https://images.unsplash.com/photo-1587241321921-91a834d82253?w=800&q=80', 'Opera Cake', 135, 'seed_french_009', 'approved'),
  ('PAUL', 'https://www.google.com/maps/search/PAUL+Bakery+Riyadh', 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800&q=80', 'Croissant', 120, 'seed_french_010', 'approved'),
  ('La Maison Ani', 'https://www.google.com/maps/search/La+Maison+Ani+Riyadh', 'https://images.unsplash.com/photo-1516685018646-549198525c1b?w=800&q=80', 'Salmon Tartare', 155, 'seed_french_011', 'approved'),
  ('Café L''Occitane', 'https://www.google.com/maps/search/Cafe+LOccitane+Diplomatic+Quarter', 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&q=80', 'Quiche Lorraine', 125, 'seed_french_012', 'approved');

-- Category 7: Lebanese & Middle Eastern Cuisine (14 restaurants)
INSERT INTO restaurants (name, google_link, image_url, best_dish, vote_count, created_by_device_id, status)
VALUES
  ('Lusin', 'https://www.google.com/maps/search/Lusin+Centria+Mall+Riyadh', 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=800&q=80', 'Armenian Kebabs', 175, 'seed_middle_east_001', 'approved'),
  ('Em Sherif Café', 'https://www.google.com/maps/search/Em+Sherif+Cafe+Riyadh', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', 'Mezze Platter', 195, 'seed_middle_east_002', 'approved'),
  ('Burj Al Hamam', 'https://www.google.com/maps/search/Burj+Al+Hamam+Al+Takhassousi', 'https://images.unsplash.com/photo-1606787366850-de6330128bfc?w=800&q=80', 'Mixed Grill', 160, 'seed_middle_east_003', 'approved'),
  ('Villa Fayrouz', 'https://www.google.com/maps/search/Villa+Fayrouz+Al+Olaya+Riyadh', 'https://images.unsplash.com/photo-1558030006-450675393462?w=800&q=80', 'Lamb Chops', 155, 'seed_middle_east_004', 'approved'),
  ('Shababïk', 'https://www.google.com/maps/search/Shababik+As+Sulimaniyah+Riyadh', 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=800&q=80', 'Fattoush', 150, 'seed_middle_east_005', 'approved'),
  ('Leila Min Lebnen', 'https://www.google.com/maps/search/Leila+Min+Lebnen+Al+Safarat', 'https://images.unsplash.com/photo-1603360946369-dc9bb6258143?w=800&q=80', 'Tabbouleh', 125, 'seed_middle_east_006', 'approved'),
  ('Bayader Al Quds', 'https://www.google.com/maps/search/Bayader+Al+Quds+Riyadh', 'https://images.unsplash.com/photo-1585518419759-7fe2e0fbf8a6?w=800&q=80', 'Musakhan', 115, 'seed_middle_east_007', 'approved'),
  ('Al-Nafoura Restaurant', 'https://www.google.com/maps/search/Al-Nafoura+Restaurant+Namar', 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&q=80', 'Falafel Plate', 120, 'seed_middle_east_008', 'approved'),
  ('Rüya', 'https://www.google.com/maps/search/Ruya+As+Sulimaniyah+Riyadh', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&q=80', 'Turkish Kebabs', 200, 'seed_middle_east_009', 'approved'),
  ('Alaya', 'https://www.google.com/maps/search/Alaya+Riyadh', 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80', 'Hummus Beiruti', 140, 'seed_middle_east_010', 'approved'),
  ('Al Falamanki', 'https://www.google.com/maps/search/Al+Falamanki+Al+Malga+Riyadh', 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=800&q=80', 'Grilled Halloumi', 130, 'seed_middle_east_011', 'approved'),
  ('Em Sherif Sea Cafe', 'https://www.google.com/maps/search/Em+Sherif+Sea+Cafe+Laysen+Valley', 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=800&q=80', 'Grilled Sea Bass', 145, 'seed_middle_east_012', 'approved'),
  ('Beirut Khanum', 'https://www.google.com/maps/search/Beirut+Khanum+Hittin+Riyadh', 'https://images.unsplash.com/photo-1603360946369-dc9bb6258143?w=800&q=80', 'Kibbeh Nayeh', 135, 'seed_middle_east_013', 'approved'),
  ('MLLe', 'https://www.google.com/maps/search/MLLe+Laysen+Valley+Riyadh', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', 'Lebanese Brunch', 140, 'seed_middle_east_014', 'approved');

-- ============================================================================
-- VERIFICATION: Show what was imported
-- ============================================================================
SELECT COUNT(*) as total_restaurants FROM restaurants;
SELECT name, best_dish, vote_count FROM restaurants ORDER BY vote_count DESC LIMIT 10;
