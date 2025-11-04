# Quick Start Guide

## ✅ What's Already Done

- ✅ Vue 3 + Vite project created
- ✅ Supabase credentials configured in `.env.local`
- ✅ All components built and ready
- ✅ Database schema SQL prepared

## 🚀 Next Steps (3 steps to launch)

### Step 1: Create Database Schema (5 minutes)

1. Open your Supabase dashboard: https://app.supabase.com
2. Select project `riyadh100`
3. Click **SQL Editor** → **New Query**
4. Copy all content from `supabase/schema.sql` file in this project
5. Paste into SQL Editor
6. Click **Run**
7. Wait for success ✓

**Expected result**: You should see 2 new tables: `restaurants` and `votes`

### Step 2: Enable Realtime (3 minutes)

In Supabase **Table Editor**:

1. Click `restaurants` table
2. Click **Realtime** toggle (top right) → Enable
3. Click `votes` table
4. Click **Realtime** toggle → Enable

✓ Done! Real-time voting updates will now work.

### Step 3: Run Your App (2 minutes)

```bash
# Navigate to project
cd "/Users/ahmad/Workshop/Create Modern UI Design/riyadh-restaurants-voting"

# Start development server
npm run dev
```

Open **http://localhost:5173** in your browser 🎉

---

## 📊 Add Sample Data (Optional)

If you want to test with sample restaurants:

1. In Supabase **SQL Editor** → **New Query**
2. Copy content from `scripts/seed-data.sql`
3. Paste and click **Run**

This adds 20 sample restaurants with vote counts.

---

## 🧪 Test the App

1. **View restaurants**: See the list on "All Restaurants" tab
2. **Vote**: Click vote button (you can vote for 5 total)
3. **Create**: Go to "Add Restaurant" tab, enter name & Google link
4. **Real-time**: Open in 2 browser tabs, vote in one and see updates in other

---

## 📁 Project Files

- `.env.local` ← Your Supabase config (already set up ✓)
- `src/App.vue` ← Main app
- `supabase/schema.sql` ← Database structure (run this first!)
- `scripts/seed-data.sql` ← Sample restaurants (optional)
- `SUPABASE_SETUP.md` ← Detailed setup guide
- `README.md` ← Full documentation

---

## ⚡ Commands

```bash
# Development
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

---

## 🎯 What You Get

✨ A fully functional voting app with:
- No sign-up required
- Device-based tracking (max 1 restaurant per device)
- Max 5 votes per device
- Real-time vote updates
- Top 100 restaurants list
- Responsive mobile design

---

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| App shows error connecting | Check `.env.local` has correct credentials |
| No restaurants showing | Run `supabase/schema.sql` first |
| Votes don't update in real-time | Enable Realtime for both tables |
| Can't create restaurant | This is correct - max 1 per device |
| Need more restaurants | Run `scripts/seed-data.sql` for samples |

---

## 📞 Need Help?

1. Check `SUPABASE_SETUP.md` for detailed instructions
2. Check `README.md` for full documentation
3. Review errors in browser console (F12)

---

**Ready?** Start with Step 1 above! 🚀
