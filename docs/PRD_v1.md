# Product Requirements Document (PRD)
**Project Name:** Ontario Kids Discovery (Code Name)
**Version:** 1.0
**Status:** Draft
**Language:** English

## 1. Executive Summary
**Core Value Proposition:** An AI-driven, structured decision-making platform for parents in Ontario. It addresses the pain points of "information overload" and "decision fatigue" regarding family activities, daycares, and kid-friendly dining.
**Key Differentiators:**
- **Hybrid Data:** Combines OpenStreetMap (OSM) data with AI-curated event feeds.
- **Smart Recommendations:** Weighted ranking algorithm based on distance, popularity, and seasonality (e.g., "Worth the drive").
- **Family-Centric:** Shared family profiles and data synchronization.

---

## 2. Navigation Structure

### 2.1 Bottom Navigation Bar (5 Tabs)
1.  **Home**: The Daily Dashboard (Smart Feed).
2.  **Play**: Activity Directory & Map (Deep Search).
3.  **Learn**: Daycare & Schools (Safety Focus).
4.  **Eat**: Kid-Friendly Dining.
5.  **Family**: Profile & Settings.

### 2.2 Top Navigation (Global)
- **Left**: Location Capsule (e.g., "Markham, ON" - tap to switch city).
- **Middle**: Search Entry ("Search farms, daycares...").
- **Right**: Notification Bell (Event reminders, Weather alerts).

---

## 3. Module Breakdown

### 🏠 Tab 1: Home (The Dashboard)
*Objective: Aggregated recommendations and user status. Not a directory, but a feed.*

* **Weather Banner**: Personalized greeting based on current weather (e.g., "Rainy today? Check out indoor playgrounds").
* **Upcoming Schedule**: Shows the immediate next event from the user's "Plan to go" list.
* **Featured Collections (Curated)**: Horizontal scroll cards (e.g., "Top 10 Pumpkin Farms", "Best Splash Pads").
* **Mixed Feed**: A "For You" stream combining high-weighted items from Play, Learn, and Eat categories.

### 🎢 Tab 2: Play (The Activity Hub)
*Objective: Deep search, filtering, and map exploration for activities.*

* **Top Filters (Chips)**: `All`, `Indoor`, `Outdoor`, `Free`, `Seasonal (e.g., Strawberry Picking)`.
* **Discovery Feed**: Infinite scroll of activities.
    * **Algorithm**: Gravity Model (Score = Distance Weight + Popularity + Seasonal Bonus).
    * **Labels**: "Worth the Drive", "15km away", "Best for ages 3-6".
* **Map Mode**: Full-screen map view with radius slider (5km / 20km / 100km+).
* **Detail Page**:
    * High-res images.
    * **AI Summary**: "Pros: Free parking. Cons: Crowded on weekends."
    * **Action**: "Add to Plan", "Navigate".

### 🏫 Tab 3: Learn (Daycare Focus)
*Objective: Safety transparency and availability tracking.*

* **Map-First Interface**: Default view centers on user's home address.
* **Safety Indicators**:
    * 🟢 **Clean Record**: No major violations in 3 years.
    * 🔴 **Warning**: Recent compliance issues (sourced from Government Data).
* **Filters**: `Infant (0-18m)`, `Subsidy Available`, `CWELCC ($10/day)`.
* **AI Review Summary**: Aggregated pros/cons from Google Reviews and local forums.

### 🍔 Tab 4: Eat (Kid-Friendly Dining)
*Objective: Stress-free dining options.*

* **Curated List**: Only lists restaurants with specific kid-friendly tags.
* **Tag System**: `#HighChair`, `#PlayArea`, `#KidsMenu`, `#CrayonsProvided`.
* **Contextual Suggestion**: "Lunch spots near [Selected Playground]".

### 👨‍👩‍👧‍👦 Tab 5: Family (Profile & Sync)
*Objective: Data synchronization and personalization.*

* **Family Unit**:
    * **Invite System**: Generate a link/QR code to invite a partner (Mom & Dad sync).
    * **Kid Profile**: Birthdate (for age-appropriate recommendations) and Gender.
* **Smart Planner**:
    * List of "Plan to go" events.
    * **Sync to Calendar**: Export to iOS/Google Calendar.
    * **Weather Alert**: Warning if an outdoor plan coincides with rain.
* **Shared Favorites**:
    * Lists: "Wishlist", "Daycare Watchlist", "Tried & Loved".

---

## 4. Technical Requirements (High Level)
* **Frontend**: Flutter (iOS/Android).
* **Backend**: Supabase (PostgreSQL + PostGIS).
* **AI Agent**: Python Cloud Functions + Google Gemini 3 (for event scraping and review summarization).
* **Map Source**: OpenStreetMap / Mapbox.
