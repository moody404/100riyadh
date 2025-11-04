# 🍽️ Riyadh Restaurants Voting App

A modern, responsive web application for discovering and voting on the best restaurants in Riyadh. Vote for your favorite restaurants without signing up!

## ✨ Features

- **Vote Without Sign-up**: No authentication required, just vote!
- **Add Restaurants**: Create new restaurants with just name and Google Maps link
- **Smart Limits**:
  - Each device can create only 1 restaurant
  - Each device can vote for up to 5 restaurants
- **Real-time Updates**: See vote counts update instantly
- **Top 100 Ranking**: Restaurants ranked by total votes
- **Responsive Design**: Works great on desktop, tablet, and mobile
- **No Database Sign-ups**: Uses localStorage for device tracking

## 🚀 Quick Start

### Prerequisites
- Node.js 16+
- Supabase account (free at https://supabase.com)
- Netlify account (free at https://netlify.com)

### Installation

1. **Clone/Download the project**
   ```bash
   cd riyadh-restaurants-voting
   npm install
   ```

2. **Set up Supabase**
   - Create a new Supabase project
   - Run the SQL from `SETUP.md` to create tables
   - Copy your Supabase URL and Anon Key

3. **Configure Environment**
   ```bash
   cp .env.example .env.local
   ```

   Edit `.env.local`:
   ```
   VITE_SUPABASE_URL=https://your-project.supabase.co
   VITE_SUPABASE_ANON_KEY=your-anon-key
   ```

4. **Run Locally**
   ```bash
   npm run dev
   ```

   Open http://localhost:5173

5. **Deploy to Netlify**
   ```bash
   npm run build
   netlify deploy --prod --dir=dist
   ```

## 📋 How It Works

### Device Tracking
The app generates a unique device ID stored in localStorage. This ID is used to:
- Prevent creating more than 1 restaurant per device
- Prevent voting more than 5 times per device
- Track which restaurants you've voted for

### Voting System
- Click the "Vote" button to vote for a restaurant
- You can vote for up to 5 different restaurants
- Once voted, the button changes to "✓ Voted"
- When you reach 5 votes, no more voting is allowed

### Creating Restaurants
- Click "Add Restaurant" tab
- Enter restaurant name and Google Maps link
- Your vote is automatically counted
- You cannot create another restaurant on this device

## 🏗️ Tech Stack

- **Frontend**: Vue 3 + Vite
- **Backend**: Supabase (PostgreSQL)
- **Hosting**: Netlify
- **Database**: Supabase
- **Real-time**: Supabase Realtime subscriptions

## 📁 Project Structure

```
src/
├── App.vue                        # Main application
├── components/
│   ├── RestaurantCard.vue        # Restaurant display card
│   ├── RestaurantList.vue        # List of restaurants
│   └── CreateRestaurantForm.vue  # Add restaurant form
├── utils/
│   ├── deviceId.js               # Device ID management
│   └── restaurants.js            # Database operations
└── supabaseClient.js             # Supabase config
```

## 🎨 UI Components

### RestaurantCard
Displays a single restaurant with:
- Restaurant name
- Vote count badge
- Google Maps link
- Vote button

### RestaurantList
Shows top 100 restaurants:
- Sorted by vote count
- Real-time vote updates
- User's vote progress (X/5)

### CreateRestaurantForm
Simple form to add restaurants:
- Name input
- Google Maps URL input
- Validation and error handling
- Success confirmation

## 🔐 Security

- **No Personal Data**: App doesn't collect any personal information
- **No Passwords**: No authentication required
- **Device-based Limits**: Prevents abuse using localStorage
- **Validated Input**: Restaurant name and URL validated
- **Read-only Public Access**: Anonymous sessions only

## 🐛 Troubleshooting

**Problem**: App shows "Not authenticated" error
- **Solution**: Check `.env.local` has correct Supabase credentials

**Problem**: Votes not updating
- **Solution**: Clear browser cache and refresh page

**Problem**: Can't create restaurant (error says max reached)
- **Solution**: This is working correctly. You can only create 1 per device.
- To test on multiple devices, use different browsers or incognito windows

**Problem**: Changes not appearing in real-time
- **Solution**: Make sure Realtime is enabled in Supabase dashboard

## 📝 Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build

## 🚀 Deployment

### Netlify Setup

**Option 1: CLI Deployment**
```bash
npm install -g netlify-cli
netlify login
npm run build
netlify deploy --prod --dir=dist
```

**Option 2: GitHub Integration**
1. Push code to GitHub
2. Connect repo in Netlify dashboard
3. Set environment variables
4. Auto-deploy on push

**Option 3: Manual Upload**
1. Run `npm run build`
2. Upload `dist` folder to Netlify

### Environment Variables (Netlify)
Set these in Netlify dashboard under "Site settings" → "Build & deploy" → "Environment":
- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

## 📖 API Reference

### Device ID Functions
- `getDeviceId()` - Get or create unique device ID
- `clearDeviceId()` - Clear stored device ID

### Restaurant Functions
- `getTopRestaurants(limit)` - Get top restaurants by votes
- `createRestaurant(name, googleLink)` - Create new restaurant
- `recordVote(restaurantId)` - Vote for a restaurant
- `getUserVoteCount()` - Get user's current vote count
- `getUserVotedRestaurants()` - Get list of voted restaurant IDs

## 🌟 Features Coming Soon

- Admin dashboard for moderation
- Restaurant categories/cuisines
- Comments and reviews
- Social sharing
- Advanced search and filtering

## 📄 License

MIT License

## 💬 Support

For issues or questions:
1. Check the SETUP.md file
2. Review Supabase documentation: https://supabase.com/docs
3. Check Netlify docs: https://docs.netlify.com

---

Made with 💚 for Riyadh restaurants
