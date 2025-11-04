# 🔧 Complete Database Setup Guide

Since you don't have direct MCP access, here's how to set up your Supabase database:

## Option 1: Using Supabase Dashboard (Easiest)

### Step 1: Create Tables via SQL Editor

1. Go to: https://app.supabase.com
2. Select project: **riyadh100**
3. Click **SQL Editor** (left sidebar)
4. Click **New Query**
5. Copy the entire SQL below and paste it:

```sql
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

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_restaurants_vote_count ON restaurants(vote_count DESC);
CREATE INDEX IF NOT EXISTS idx_restaurants_created_at ON restaurants(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_votes_device_id ON votes(device_id);
CREATE INDEX IF NOT EXISTS idx_votes_restaurant_id ON votes(restaurant_id);

-- Create function
CREATE OR REPLACE FUNCTION increment_restaurant_votes(restaurant_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE restaurants
  SET vote_count = vote_count + 1
  WHERE id = restaurant_id;
END;
$$ LANGUAGE plpgsql;

-- Enable RLS
ALTER TABLE restaurants ENABLE ROW LEVEL SECURITY;
ALTER TABLE votes ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow read all restaurants" ON restaurants
  FOR SELECT USING (true);

CREATE POLICY "Allow insert restaurants" ON restaurants
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow read all votes" ON votes
  FOR SELECT USING (true);

CREATE POLICY "Allow insert votes" ON votes
  FOR INSERT WITH CHECK (true);

-- Enable realtime
ALTER PUBLICATION supabase_realtime ADD TABLE restaurants;
ALTER PUBLICATION supabase_realtime ADD TABLE votes;
```

6. Click **RUN** button
7. Wait for success ✓

### Step 2: Import Seed Data

Once tables are created:

1. Click **New Query** again
2. Copy entire content from: `scripts/complete-seed-data.sql`
3. Paste into SQL Editor
4. Click **RUN**
5. You should see: "94 rows inserted"

### Step 3: Enable Realtime in UI

1. Click **Table Editor** (left sidebar)
2. Click **restaurants** table
3. Look for **Realtime** toggle at top-right
4. Turn it **ON**
5. Repeat for **votes** table

---

## Option 2: Using Your Local Terminal (Alternative)

If you want to use command line with Supabase CLI:

### Install Supabase CLI

```bash
npm install -g supabase
```

### Login to Supabase

```bash
supabase login
```

### Execute SQL File

```bash
supabase db push supabase/schema.sql
```

---

## Option 3: Manual SQL Execution (If Copy-Paste Issues)

If the SQL copy-paste isn't working, here's what each part does:

### Create restaurants table:
```sql
CREATE TABLE restaurants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name varchar(100) NOT NULL,
  google_link text NOT NULL,
  vote_count integer DEFAULT 1,
  created_by_device_id varchar(100) NOT NULL,
  status varchar(20) DEFAULT 'approved',
  created_at timestamp with time zone DEFAULT now()
);
```

### Create votes table:
```sql
CREATE TABLE votes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  restaurant_id uuid NOT NULL REFERENCES restaurants(id) ON DELETE CASCADE,
  device_id varchar(100) NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  UNIQUE(restaurant_id, device_id)
);
```

Run these one at a time if needed.

---

## Verification Checklist

After setup, verify everything:

- [ ] Go to Table Editor
- [ ] See **restaurants** table
- [ ] See **votes** table
- [ ] Both have Realtime **enabled**
- [ ] Can see columns in each table
- [ ] No error messages

---

## What Each Part Does

| Component | Purpose |
|-----------|---------|
| restaurants table | Stores all restaurant data |
| votes table | Tracks user votes |
| indexes | Makes queries faster |
| increment_restaurant_votes function | Updates vote count |
| Row Level Security (RLS) | Controls data access |
| Realtime | Live updates between users |

---

## Common Issues & Solutions

| Problem | Solution |
|---------|----------|
| "Table already exists" | Tables are already created ✓ |
| "Syntax error" | Make sure you copied entire SQL |
| "Permission denied" | You need to be logged in as owner |
| "No tables showing" | Refresh the page or check project |
| "Realtime not working" | Enable the toggle in Table Editor |

---

## Next Steps After Database Setup

1. ✅ Create tables (this step)
2. ✅ Import 94 restaurants (scripts/complete-seed-data.sql)
3. ✅ Enable Realtime toggles
4. ✅ Run: `npm run dev`
5. ✅ Open: http://localhost:5173
6. ✅ Test voting app!

---

## Files Available

- **supabase/schema.sql** - Database schema (tables, functions, policies)
- **scripts/complete-seed-data.sql** - 94 restaurants to import
- **CREATE_TABLES_NOW.txt** - Quick reference guide
- **IMPORT_INSTRUCTIONS.txt** - How to import restaurants

---

## Still Having Issues?

1. Check Supabase dashboard status
2. Verify project is running
3. Check that you're in the right project (riyadh100)
4. Clear browser cache and refresh
5. Try a different browser

---

**Once tables are created, reply and I can help with the next steps!**
