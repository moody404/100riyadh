# Supabase Setup Instructions

## Project Details
- **Project Name**: riyadh100
- **Project URL**: https://cincckjmkglcrbiupvip.supabase.co
- **API Key**: Already configured in `.env.local`

## Step 1: Create Database Tables

1. Go to your Supabase dashboard: https://app.supabase.com
2. Select your project `riyadh100`
3. Click on **SQL Editor** in the left sidebar
4. Click **New Query**
5. Copy the entire SQL from `supabase/schema.sql` (in this project folder)
6. Paste it into the SQL editor
7. Click **Run** button (or press Cmd+Enter)

Wait for the query to complete successfully.

## Step 2: Verify Tables Were Created

1. Go to **Table Editor** in the left sidebar
2. You should see two tables:
   - `restaurants`
   - `votes`

If you don't see them, check the SQL query output for errors.

## Step 3: Enable Realtime (Important!)

1. In **Table Editor**, click on **restaurants** table
2. In the top-right, click the **Realtime** toggle to enable it
3. Repeat for the **votes** table

This is crucial for real-time updates to work in the app!

## Step 4: Configure Row Level Security (RLS)

The SQL script already creates the RLS policies. To verify they're set up:

1. Go to **Authentication** → **Policies**
2. Select the `restaurants` table
3. You should see two policies:
   - "Allow read all restaurants" (SELECT)
   - "Allow insert restaurants" (INSERT)
4. Repeat for `votes` table

## Step 5: Add Seed Data (Optional)

If you have seed data, you can add it using the **Table Editor**:

1. Click the **restaurants** table
2. Click **Insert row** (or the **+** button)
3. Fill in:
   - `name`: Restaurant name
   - `google_link`: Google Maps link
   - `vote_count`: Starting votes (default 1)
   - `created_by_device_id`: Device ID of creator
   - `status`: "approved"
4. Click **Save**

Or insert multiple rows using SQL:

```sql
INSERT INTO restaurants (name, google_link, vote_count, created_by_device_id, status)
VALUES
  ('Restaurant Name 1', 'https://maps.google.com/...', 5, 'device_123', 'approved'),
  ('Restaurant Name 2', 'https://maps.google.com/...', 3, 'device_456', 'approved'),
  ('Restaurant Name 3', 'https://maps.google.com/...', 2, 'device_789', 'approved');
```

## Step 6: Test the Setup

1. In your terminal, run:
   ```bash
   cd /Users/ahmad/Workshop/Create\ Modern\ UI\ Design/riyadh-restaurants-voting
   npm run dev
   ```

2. Open http://localhost:5173
3. You should see any restaurants you added in the list
4. Try voting on one - it should update immediately

## Troubleshooting

### Tables don't appear in Table Editor
- Check the SQL Editor output for errors
- Make sure you ran the entire SQL script
- Try refreshing the page

### Voting doesn't work
- Check that Realtime is enabled for both tables
- Open browser DevTools (F12) → Console for error messages
- Check Supabase dashboard → Logs for backend errors

### Can't see environment variables working
- Delete `.env.local` and recreate it
- Make sure you're using `npm run dev`, not `npm start`
- Restart the dev server after changing `.env.local`

## Database Schema Reference

### restaurants table
```
id (UUID, Primary Key)
name (VARCHAR 100)
google_link (TEXT)
vote_count (INTEGER, default 1)
created_by_device_id (VARCHAR 100)
status (VARCHAR 20, default 'approved')
created_at (TIMESTAMP, auto-set)
```

### votes table
```
id (UUID, Primary Key)
restaurant_id (UUID, Foreign Key → restaurants.id)
device_id (VARCHAR 100)
created_at (TIMESTAMP, auto-set)
Unique constraint: (restaurant_id, device_id)
```

## Environment Variables

Your `.env.local` is already configured with:
- `VITE_SUPABASE_URL`: Project URL
- `VITE_SUPABASE_ANON_KEY`: Anonymous API key

These are used by the app to connect to Supabase.

## Next Steps

After completing the setup:
1. Test the app locally: `npm run dev`
2. Deploy to Netlify (see README.md)
3. Add more restaurants and test voting
4. Share the link with others to gather votes!

## Notes

- The database password is not needed for the Vue app - it uses the API key
- The API key you're using is public (for frontend use) - this is safe
- Row Level Security (RLS) ensures users can only do allowed operations
- Realtime requires a WebSocket connection - some corporate networks may block it
