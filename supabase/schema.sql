-- Create restaurants table
CREATE TABLE IF NOT EXISTS restaurants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name varchar(100) NOT NULL,
  google_link text NOT NULL,
  vote_count integer DEFAULT 1,
  created_by_device_id varchar(100) NOT NULL,
  status varchar(20) DEFAULT 'approved',
  created_at timestamp with time zone DEFAULT now()
);

-- Create votes table
CREATE TABLE IF NOT EXISTS votes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  restaurant_id uuid NOT NULL REFERENCES restaurants(id) ON DELETE CASCADE,
  device_id varchar(100) NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  UNIQUE(restaurant_id, device_id)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_restaurants_vote_count ON restaurants(vote_count DESC);
CREATE INDEX IF NOT EXISTS idx_restaurants_created_at ON restaurants(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_votes_device_id ON votes(device_id);
CREATE INDEX IF NOT EXISTS idx_votes_restaurant_id ON votes(restaurant_id);

-- Create function to increment restaurant votes
CREATE OR REPLACE FUNCTION increment_restaurant_votes(restaurant_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE restaurants
  SET vote_count = vote_count + 1
  WHERE id = restaurant_id;
END;
$$ LANGUAGE plpgsql;

-- Enable Row Level Security
ALTER TABLE restaurants ENABLE ROW LEVEL SECURITY;
ALTER TABLE votes ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for restaurants
CREATE POLICY "Allow read all restaurants" ON restaurants
  FOR SELECT USING (true);

CREATE POLICY "Allow insert restaurants" ON restaurants
  FOR INSERT WITH CHECK (true);

-- Create RLS policies for votes
CREATE POLICY "Allow read all votes" ON votes
  FOR SELECT USING (true);

CREATE POLICY "Allow insert votes" ON votes
  FOR INSERT WITH CHECK (true);

-- Enable realtime
ALTER PUBLICATION supabase_realtime ADD TABLE restaurants;
ALTER PUBLICATION supabase_realtime ADD TABLE votes;
