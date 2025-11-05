-- Fix vote counting with triggers
-- This ensures vote_count is always accurate and prevents race conditions

-- First, let's fix existing vote counts by calculating from actual votes
UPDATE restaurants r
SET vote_count = (
  SELECT COUNT(*)
  FROM votes v
  WHERE v.restaurant_id = r.id
)
WHERE EXISTS (
  SELECT 1 FROM votes v WHERE v.restaurant_id = r.id
);

-- For restaurants with no votes, set to 0
UPDATE restaurants
SET vote_count = 0
WHERE vote_count IS NULL OR NOT EXISTS (
  SELECT 1 FROM votes WHERE restaurant_id = restaurants.id
);

-- Drop existing trigger if it exists
DROP TRIGGER IF EXISTS update_restaurant_vote_count_on_insert ON votes;
DROP TRIGGER IF EXISTS update_restaurant_vote_count_on_delete ON votes;
DROP FUNCTION IF EXISTS update_restaurant_vote_count();

-- Create function to update vote count
CREATE OR REPLACE FUNCTION update_restaurant_vote_count()
RETURNS TRIGGER AS $$
BEGIN
  -- Handle INSERT
  IF TG_OP = 'INSERT' THEN
    UPDATE restaurants
    SET vote_count = vote_count + 1
    WHERE id = NEW.restaurant_id;
    RETURN NEW;

  -- Handle DELETE
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE restaurants
    SET vote_count = GREATEST(vote_count - 1, 0)
    WHERE id = OLD.restaurant_id;
    RETURN OLD;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for INSERT
CREATE TRIGGER update_restaurant_vote_count_on_insert
AFTER INSERT ON votes
FOR EACH ROW
EXECUTE FUNCTION update_restaurant_vote_count();

-- Create trigger for DELETE (in case votes are removed)
CREATE TRIGGER update_restaurant_vote_count_on_delete
AFTER DELETE ON votes
FOR EACH ROW
EXECUTE FUNCTION update_restaurant_vote_count();

-- Verify counts are correct
SELECT
  r.name,
  r.vote_count as stored_count,
  COUNT(v.id) as actual_count,
  CASE
    WHEN r.vote_count = COUNT(v.id) THEN '✓ Correct'
    ELSE '✗ Mismatch'
  END as status
FROM restaurants r
LEFT JOIN votes v ON r.id = v.restaurant_id
GROUP BY r.id, r.name, r.vote_count
ORDER BY r.vote_count DESC;
