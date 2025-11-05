-- Add best_dish field to restaurants table
ALTER TABLE restaurants
ADD COLUMN IF NOT EXISTS best_dish varchar(200);

-- Add a comment
COMMENT ON COLUMN restaurants.best_dish IS 'The signature or most popular dish of this restaurant';
