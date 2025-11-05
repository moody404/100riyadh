-- Add image URL field to restaurants table
ALTER TABLE restaurants
ADD COLUMN IF NOT EXISTS image_url text;

-- Update existing restaurants with placeholder images
-- You can replace these with actual restaurant images later
UPDATE restaurants SET image_url = 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&q=80' WHERE image_url IS NULL;

-- Optional: Add a comment
COMMENT ON COLUMN restaurants.image_url IS 'URL to restaurant image (can be from Unsplash, Google, or uploaded)';
