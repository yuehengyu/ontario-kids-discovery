# Product Requirements Document (PRD)

**Project Name:** Ontario Kids Discovery
**Version:** 1.2 (Master Detailed)
**Status:** Approved Draft
**Language:** English

---

## 1. Executive Summary
**Core Mission:** To solve "Information Overload" and "Decision Fatigue" for parents in Ontario. We provide a structured, AI-driven decision engine that helps parents find activities, safe daycares, and kid-friendly dining.
**Key Differentiators:**
- **Hybrid Data Strategy:** Combines cost-effective OpenStreetMap data (Places) with AI-curated dynamic feeds (Events).
- **Gravity Algorithm:** A recommendation logic that balances distance, popularity, and seasonal relevance.
- **Family-Centric:** Built from the ground up for dual-parent usage with data synchronization.

---

## 2. Global Navigation & Framework

### 2.1 Top Navigation Bar (Global Sticky)
*Always visible at the top of the screen.*

#### **Left: Location Capsule**
- **UI:** A pill-shaped button displaying the current city (e.g., "📍 Markham, ON").
- **Interaction:** Tapping opens a "Switch City" modal.
    - *Popular Cities List:* Toronto, Mississauga, Ottawa, Vaughan, etc.
    - *Auto-Locate:* "Use Current GPS Location".
- **Logic:** Changing the city triggers a global refresh of the Home Feed, Play Map, and Event recommendations.

#### **Middle: Search Entry**
- **UI:** A search icon 🔍 or a pseudo-input box with rotating placeholder text.
    - *Placeholders:* "Search farms...", "Find CNE tickets...", "Daycare near me...".
- **Interaction:** Tapping enters the **Global Search Page**.
    - Supports **"Magic Search"** (Natural Language): e.g., "Places to play water for a 3-year-old."

#### **Right: Notification Center**
- **UI:** Bell icon with a numeric Red Badge for unread items.
- **Notification Categories:**
    - **Event Reminders:** "Your saved event 'Pumpkin Fest' ends in 3 days."
    - **Itinerary Alerts:** "Tomorrow's plan: Outdoor farm. Weather warning: 🌧️ Rain expected."
    - **System/Daycare:** "New safety report available for 'Little Angels Daycare'."
    - **Social:** "Mom added a new place to Wishlist."

---

## 3. Module Breakdown

### 🏠 Tab 1: Home (The Dashboard)
*Objective: The centralized "Morning Briefing" and aggregated recommendations. Not a directory, but a personalized feed.*

1.  **Weather Banner (Contextual)**
    - Displays a personalized greeting based on local weather.
    - *Logic:* If raining, display "It's wet outside 🌧️. Check out these **Indoor** spots."

2.  **Upcoming Schedule (The "Next Step")**
    - Shows the single immediate next event from the user's "Plan to Go" list.
    - *UI:* "You are going to **CNE** this Saturday. 🚗 45 mins drive."

3.  **The "For You" Mix Feed**
    - An infinite scroll combining high-weighted items from Play, Learn, and Eat.
    - *Content Ratio:* 30% Events (Limited Time) + 50% Places (High Quality) + 20% Seasonal Collections.

---

### 🎢 Tab 2: Play (Activity Hub)
*Objective: The core traffic driver. Replaces "Little Red Book" with structured data.*

#### **1. Discovery Feed ("Little Red Book" Mode)**
**A. Top Filter Chips (Dynamic)**
- **Standard Chips:** `All`, `Indoor`, `Outdoor`, `Free`.
- **Dynamic Seasonal Chips (Backend Configured):**
    - *Summer (June-Aug):* `🍓 Strawberry Picking`, `🌊 Splash Pads`.
    - *Fall (Sept-Oct):* `🎃 Pumpkin Farms`, `🍁 Maple Watch`.

**B. Collections Carousel (Operations)**
- Horizontal scroll cards for curated topics.
- *Examples:* "Top 10 Indoor Playgrounds in Mississauga", "Best Fall Hikes (<1.5h drive)".

**C. The Waterfall Feed (Infinite Scroll)**
- **Algorithm:** The "Gravity Model".
    - *Formula:* Score = (Distance Weight) + (Popularity Score) + (Seasonal Bonus).
    - *Logic:* A farm 100km away with the `#Pumpkin` tag in October will outrank a generic park 2km away.
- **Card Content Design:**
    - **Image:** Large, high-quality cover image (4:3 or 1:1 aspect ratio).
    - **Title:** Name of the Place or Event.
    - **Core Tags:** `🚗 15km`, `⭐️ 4.8`, `Ages 2-6`.
    - **AI Recommendation Reason:** "🔥 Trending this week", "🍁 Peak Fall Colors", "☔️ Perfect for Rainy Days".
    - **Special Label:** **"Worth the Drive"** badge for high-ranking distant locations (>50km).

#### **2. Map Exploration Mode**
- **Entry:** Floating Action Button (FAB) on the Feed page: "🗺️ Map Mode".
- **Interaction:**
    - Full-screen map with pins.
    - Bottom sheet displays the card of the selected pin (swipe left/right to browse).
- **Radius Control:** Bottom slider or pills to adjust search scope.
    - `Nearby (5km)`: Quick outings.
    - `Day Trip (20km)`: Weekend plans.
    - `Getaway (100km+)`: Provincial parks, major attractions.
- **Pin Types:** Color-coded pins (e.g., 🔵 Indoor, 🟢 Outdoor, 🔴 Limited-Time Event).

#### **3. Detail Page (Deep Dive)**
- **Header:** Media carousel (Images + Video support).
- **Info Card:**
    - Address (Click to Navigate via Google Maps/Waze).
    - Status: "Open Today" / "Closed".
    - Price Range: `$$$` (e.g., "$20/adult").
    - **Age Suggestion:** e.g., "Best for: 3-8 years".
- **AI Smart Summary (The "Soul"):**
    - *Highlights:* "✨ Free parking, extensive splash pad, clean washrooms."
    - *Warnings:* "⚠️ Long lineup on weekends, arrive before 10 AM."
- **Related Events:** "This farm is hosting 'Halloween Haunt' this weekend."
- **Action Bar:** `❤️ Favorite`, `📅 Add to Plan`, `🔗 Share`.

---

### 🏫 Tab 3: Learn (Daycare & Schools)
*Objective: Solving the "Trust" and "Availability" anxiety.*

#### **1. Map-First Interface**
- **Default View:** Map centered on the user's home address (Daycare search is strictly hyper-local).
- **Filters:**
    - **Age Group:** `Infant (0-18m)`, `Toddler (18m-30m)`, `Preschool (30m+)`.
    - **Type:** `Licensed Center`, `Home Child Care`.
    - **Hard Criteria:** `Subsidy Available`, `CWELCC ($10/day program)`.

#### **2. Directory List & Cards**
- **Safety Shield System (Crucial):**
    - 🟢 **Clean Record:** No major violations in the last 3 years.
    - 🔴 **Warning:** Has outstanding or recent critical violations (sourced from Govt Data).
- **Waitlist Status (Crowdsourced/AI):**
    - Status tags: `Crowded`, `Has Spots`, `Waitlist > 1 Year`.

#### **3. Institution Detail Page**
- **Official Data:** License Number, Capacity, Date of Last Inspection.
- **AI Review Lens:**
    - Aggregates comments from Google/Forums into tags.
    - *Pros:* `#CaringTeachers`, `#GoodFood`, `#AppUpdates`.
    - *Cons:* `#HighTurnover`, `#FrequentSickness`, `#PoorCommunication`.
- **My CRM Notes (Private):**
    - Parent can log status: "Called on Dec 1st, Director said spots open in Sept."

---

### 🍔 Tab 4: Eat (Kid-Friendly Dining)
*Objective: Stress-free dining. Not a full restaurant directory.*

#### **1. Curated Discovery**
- **Inclusion Criteria:** Only lists restaurants with verified Kid-Friendly attributes.
- **Tag-Based Filtering:**
    - `#HighChair`: Essential for babies.
    - `#PlayArea`: Restaurants with slides/ball pits (Weighted Higher).
    - `#KidsMenu`: Dedicated menu for children.
    - `#StrollerFriendly`: Wide aisles / Ramp access.
    - `#Crayons`: Provides coloring kits.

#### **2. Contextual Recommendation**
- **Scenario:** "I am at [Playground A]. Where can we eat?"
- **Logic:** Show "Eat" recommendations on the "Play" detail page bottom section.

---

### 👨‍👩‍👧‍👦 Tab 5: Family (Profile & Sync)
*Objective: The Single Source of Truth for the household.*

#### **1. The Family Unit**
- **Concept:** One Family ID, multiple User Accounts (Mom & Dad).
- **Invite Flow:**
    - User A clicks "Invite Partner".
    - App generates a 6-digit code or Deep Link.
    - User B enters code -> Accounts linked. Data merged.
- **Kid Profile:**
    - Fields: Nickname, Birth Date, Gender.
    - *Usage:* Used by the recommendation algorithm (e.g., Don't show "Trampoline Park" to a 1-year-old).

#### **2. Smart Planner (Itinerary)**
- **Timeline View:** Shows events marked as "Plan to go".
- **Actions:**
    - `Export`: Sync to System Calendar (iOS/Google).
    - `Maps`: One-click navigation.
- **Weather Watch:** Shows a 🌧️ warning icon on the specific itinerary item if rain is forecast for that day/location.

#### **3. Shared Favorites**
- **Categorized Lists (Synced):**
    - `Wishlist`: Places we want to go.
    - `Daycare Watchlist`: Special list showing CRM status (Contacted/Visited/Waitlisted).
    - `Tried & Loved`: Restaurants/Places we liked.

---

## 4. Non-Functional Requirements (NFR)

#### **Data Freshness**
- **Events:** Fetched weekly via AI Agents (Cron Job).
- **Daycare Data:** Synced monthly with Ontario Open Data Portal.
- **Places:** Enriched on-demand (Lazy Loading) to save API costs.

#### **Privacy**
- Kid's birth date is strict **Internal Use Only** (for algorithm). Never shared with advertisers.
- Home Address is stored locally or encrypted, used only for distance calculation.

#### **Performance**
- **Feed Loading:** Must support lazy loading (pagination). First content paint < 1.5s.
- **Map Clustering:** When zoomed out, pins must cluster (e.g., "10+") to prevent UI lag.
