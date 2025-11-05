-- Run this in Supabase SQL Editor to diagnose the voting issue

-- 1. Check all restaurants and their vote counts
SELECT
  r.name,
  r.vote_count as stored_count,
  COUNT(v.id) as actual_vote_count,
  CASE
    WHEN r.vote_count = COUNT(v.id) THEN '✓ Match'
    ELSE '✗ MISMATCH'
  END as status,
  r.id,
  r.image_url IS NOT NULL as has_image
FROM restaurants r
LEFT JOIN votes v ON r.id = v.restaurant_id
GROUP BY r.id, r.name, r.vote_count, r.image_url
ORDER BY r.vote_count DESC, r.name;

-- 2. Check which restaurants have votes
SELECT
  r.name,
  r.vote_count,
  v.device_id,
  v.created_at
FROM votes v
JOIN restaurants r ON v.restaurant_id = r.id
ORDER BY r.name, v.created_at DESC;

-- 3. Count total restaurants
SELECT COUNT(*) as total_restaurants FROM restaurants;

-- 4. Count total votes
SELECT COUNT(*) as total_votes FROM votes;

-- 5. Check for restaurants with vote_count = 0 but have actual votes
SELECT
  r.name,
  r.vote_count,
  COUNT(v.id) as actual_votes
FROM restaurants r
LEFT JOIN votes v ON r.id = v.restaurant_id
WHERE r.vote_count = 0 AND EXISTS (SELECT 1 FROM votes WHERE restaurant_id = r.id)
GROUP BY r.id, r.name, r.vote_count;
