# 🚀 START HERE

Your Riyadh Restaurants Voting App is ready!

## 3️⃣ Things to Do

### 1️⃣ Set Up Database (Do this FIRST!)

Go to your Supabase project: https://app.supabase.com

Then:
1. Click **SQL Editor**
2. Click **New Query**
3. Copy everything from `supabase/schema.sql` file in this project
4. Paste into the SQL Editor
5. Click **Run**
6. ✅ Wait for it to finish (you should see success message)

**That's it!** Your database is ready.

---

### 2️⃣ Enable Realtime (Very Important!)

Still in Supabase:
1. Click **Table Editor** (left sidebar)
2. Click **restaurants** table
3. Look for **Realtime** button/toggle at top-right
4. Turn it **ON**
5. Repeat for **votes** table

**This makes voting updates instant!** ⚡

---

### 3️⃣ Run Your App

Open terminal and run:

```bash
cd "/Users/ahmad/Workshop/Create Modern UI Design/riyadh-restaurants-voting"
npm run dev
```

Then open: **http://localhost:5173**

That's it! 🎉

---

## 🧪 Test It

1. **See restaurants** - Click "All Restaurants" tab
2. **Vote** - Click the vote button (you can vote for 5)
3. **Create** - Click "Add Restaurant" tab, add a restaurant
4. **Real-time** - Open 2 browser tabs, vote in one, see update in other

---

## 📊 Have Seed Data?

Want to add sample restaurants? Run this in Supabase SQL Editor:

1. **New Query**
2. Copy from `scripts/seed-data.sql`
3. Click **Run**

This adds 20 sample restaurants! 🍽️

---

## ✅ Checklist

- [ ] Opened Supabase project
- [ ] Ran SQL from `supabase/schema.sql`
- [ ] Enabled Realtime for both tables
- [ ] Ran `npm run dev`
- [ ] Opened http://localhost:5173
- [ ] Tested voting
- [ ] Tested creating restaurant

---

## 🆘 Issues?

| Problem | What to Do |
|---------|-----------|
| "Cannot connect to database" | Check `.env.local` has credentials |
| "No restaurants showing" | Did you run the SQL? Try Step 1 again |
| "Votes don't update instantly" | Enable Realtime for both tables |
| "Can't create restaurant" | You already created one! Max 1 per device |

---

## 📚 More Info

- `QUICK_START.md` - Quick setup guide
- `README.md` - Full documentation
- `SUPABASE_SETUP.md` - Detailed database help

---

## 🚀 Ready?

1. Open Supabase → SQL Editor
2. Copy `supabase/schema.sql` and run it
3. Enable Realtime for both tables
4. Run `npm run dev`
5. Open http://localhost:5173

**Go! Go! Go!** ⚡🚀
