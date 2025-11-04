# Riyadh Restaurants Voting App - Setup Guide

## Prerequisites
- Node.js 16+ installed
- Supabase account (free tier available at https://supabase.com)
- Netlify account for deployment (https://netlify.com)

## Step 1: Create Supabase Project

1. Go to https://supabase.com and sign up/login
2. Create a new project
3. Save your Supabase URL and Anon Key

## Step 2: Create Database Tables and Functions

In your Supabase dashboard, go to the SQL Editor and run the following SQL:

```sql
-- Create restaurants table
CREATE TABLE restaurants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name varchar(100) NOT NULL,
  google_link text NOT NULL,
  vote_count integer DEFAULT 1,
  created_by_device_id varchar(100) NOT NULL,
  status varchar(20) DEFAULT 'approved',
  created_at timestamp with time zone DEFAULT now()
);

-- Create votes table
CREATE TABLE votes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  restaurant_id uuid NOT NULL REFERENCES restaurants(id) ON DELETE CASCADE,
  device_id varchar(100) NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  UNIQUE(restaurant_id, device_id)
);

-- Create index for faster queries
CREATE INDEX idx_restaurants_vote_count ON restaurants(vote_count DESC);
CREATE INDEX idx_votes_device_id ON votes(device_id);
CREATE INDEX idx_votes_restaurant_id ON votes(restaurant_id);

-- Create function to increment vote count
CREATE OR REPLACE FUNCTION increment_restaurant_votes(restaurant_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE restaurants
  SET vote_count = vote_count + 1
  WHERE id = restaurant_id;
END;
$$ LANGUAGE plpgsql;

-- Enable realtime for restaurants table
ALTER PUBLICATION supabase_realtime ADD TABLE restaurants;
ALTER PUBLICATION supabase_realtime ADD TABLE votes;
```

## Step 3: Enable Row Level Security (Optional but Recommended)

```sql
-- Enable RLS
ALTER TABLE restaurants ENABLE ROW LEVEL SECURITY;
ALTER TABLE votes ENABLE ROW LEVEL SECURITY;

-- Allow anyone to read restaurants
CREATE POLICY "Allow read restaurants" ON restaurants
  FOR SELECT USING (true);

-- Allow anyone to read votes
CREATE POLICY "Allow read votes" ON votes
  FOR SELECT USING (true);

-- Allow anyone to insert restaurants
CREATE POLICY "Allow insert restaurants" ON restaurants
  FOR INSERT WITH CHECK (true);

-- Allow anyone to insert votes
CREATE POLICY "Allow insert votes" ON votes
  FOR INSERT WITH CHECK (true);
```

## Step 4: Set Up Local Project

1. Clone or download this project
2. Install dependencies:
   ```bash
   npm install
   ```

3. Create `.env.local` file in the project root:
   ```
   VITE_SUPABASE_URL=https://your-project.supabase.co
   VITE_SUPABASE_ANON_KEY=your-anon-key-here
   ```

4. Run the development server:
   ```bash
   npm run dev
   ```

5. Open http://localhost:5173 in your browser

## Step 5: Deploy to Netlify

### Option A: Using Netlify CLI

1. Install Netlify CLI:
   ```bash
   npm install -g netlify-cli
   ```

2. Login to Netlify:
   ```bash
   netlify login
   ```

3. Deploy:
   ```bash
   npm run build
   netlify deploy --prod --dir=dist
   ```

### Option B: Connect GitHub Repository

1. Push your code to GitHub
2. Go to https://netlify.com and connect your GitHub repo
3. Set environment variables in Netlify:
   - `VITE_SUPABASE_URL`: Your Supabase URL
   - `VITE_SUPABASE_ANON_KEY`: Your Supabase Anon Key
4. Deploy button will trigger automatically on push

### Option C: Manual Deployment

1. Build the project:
   ```bash
   npm run build
   ```

2. Upload the `dist` folder to Netlify through the dashboard

## Configuration

The app uses environment variables for Supabase configuration.

**Environment Variables:**
- `VITE_SUPABASE_URL`: Your Supabase project URL
- `VITE_SUPABASE_ANON_KEY`: Your Supabase anonymous key

## Features Explained

### Device Tracking
- Uses localStorage to store a unique device ID
- Prevents users from creating more than 1 restaurant
- Prevents users from voting more than 5 times
- No authentication required

### Voting System
- Users can vote for up to 5 restaurants
- Each restaurant can only be voted once per device
- Votes are tracked in the `votes` table
- Vote counts are updated in real-time

### Restaurant Creation
- Users can create a new restaurant with just name and Google Maps link
- Creator's vote counts as the first vote
- Only 1 restaurant per device
- Restaurants are auto-approved and immediately visible

### Real-time Updates
- Uses Supabase real-time subscriptions
- Restaurant list updates when new votes are cast
- New restaurants appear immediately

## Troubleshooting

### "Not authenticated" Error
- The app uses anonymous sessions, no authentication needed
- Check that Supabase URL and Anon Key are correct

### Votes Not Updating
- Make sure realtime is enabled for both tables
- Check browser console for errors

### Can't Create Restaurant
- Clear localStorage and try again
- Or try a different browser/device

## Development

- Run dev server: `npm run dev`
- Build for production: `npm run build`
- Preview production build: `npm run preview`

## Project Structure

```
src/
├── App.vue                          # Main app component
├── components/
│   ├── RestaurantCard.vue          # Single restaurant card
│   ├── RestaurantList.vue          # List of all restaurants
│   └── CreateRestaurantForm.vue    # Form to create new restaurant
├── utils/
│   ├── deviceId.js                 # Device ID utilities
│   ├── restaurants.js              # Restaurant API functions
└── supabaseClient.js               # Supabase configuration
```

## Support

For issues or questions, check the Supabase and Netlify documentation.
