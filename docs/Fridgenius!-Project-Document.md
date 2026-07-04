# **Project Document: Fridgenius\!**

AI-Powered Ingredient-to-Recipe Mobile App

## 1\. Overview

Fridgenius\! is a Flutter mobile app (Android and iOS) that turns whatever ingredients a user already has into a cooked meal. The user inputs ingredients they own, and Gemini API generates ranked recipe suggestions, exact matches first, then recipes that need 1-2 additional items. The app also includes a curated recipe library, a save/favorites system, and a community sharing layer for posting and browsing user-generated recipes.

**The Golden Sentence:** Fridgenius\! turns whatever's in your kitchen into a cooked meal, a shareable post, and a daily habit, all in one Gemini-powered flow.

## 2\. Problem Statement

Home cooks and students frequently have random ingredients on hand but no clear idea what to cook with them. Generic recipe apps require searching by dish name, which doesn't help when you're starting from ingredients, not a target dish. This leads to food waste, repeated takeout/delivery orders, and daily decision fatigue around meals.

**Target users:** Budget-conscious students and young home cooks who want fast, low-effort answers to "what can I cook right now."

## 3\. Goals

- Let users get a usable recipe within 30 seconds of opening the app, with zero account setup required.  
- Reduce food waste by surfacing recipes that use ingredients close to running out.  
- Build a habit loop around the app through saved favorites, shareable recipe cards, and community recipe browsing.

## 4\. Features

### 4.1 Core Features (Phase 1, MVP)

| Feature | Description |
| :---- | :---- |
| Ingredient Input | Text-based input where users list ingredients they have on hand. |
| Gemini Recipe Generation | Gemini API processes the ingredient list and returns ranked recipes: exact matches first, then recipes needing 1-2 extra items, with substitution suggestions where reasonable. |
| Recipe Card Display | Structured recipe output showing title, ingredients, steps, estimated cook time, and a flag for any missing items. |
| Curated Recipe Library | A pre-loaded set of recipes stored in Firestore, used as fallback content and to seed the app so it isn't empty on first launch. |
| Save/Favorites | Users can save generated or curated recipes to a personal list for later reference. |
| Firebase Auth | Basic email or Google sign-in, required only for saving favorites or posting to the community feed, not for the core generation flow. |

### 4.2 Extension Features (Phase 2\)

| Feature | Description |
| :---- | :---- |
| Shareable Recipe Cards | Export a recipe card as an image or shareable link to send via group chats or social apps. |
| Near-Expiry Tagging | Users can tag ingredients as close to expiring, and the app prioritizes recipes that use those first. |
| Recipe History | A log of past generated recipes tied to the user's account. |

### 4.3 Ecosystem Features (Phase 3, Stretch Goals)

| Feature | Description |
| :---- | :---- |
| Community Feed | Users can publish their AI-generated or personalized recipes to a public feed others can browse, save, or remix. |
| Daily Mystery Basket | An optional daily challenge mode where Gemini generates a recipe from a randomized, limited ingredient set, with a shareable result card. |

## 5\. Tech Stack

| Layer | Technology | Purpose |
| :---- | :---- | :---- |
| Frontend Framework | Flutter | Cross-platform UI for Android and iOS from a single codebase. |
| State Management | Riverpod | Manages app state, including ingredient input, recipe results, and user session, with clean separation between UI and logic. |
| Navigation | GoRouter | Declarative routing between screens (home, recipe detail, favorites, community feed, profile). |
| Backend / Database | Firebase (Firestore) | Stores curated recipes, user favorites, community posts, and user profiles. |
| Authentication | Firebase Auth | Email and/or Google sign-in for saving favorites and posting to community feed. |
| Image Storage | Firebase Storage | Stores recipe images and any user-uploaded photos for community posts. |
| AI Recipe Generation | Gemini API | Generates ranked recipes from a user's ingredient list, using structured JSON output mode for reliable client-side parsing. |
| Sharing | Native share sheet (Flutter share plugin) | Lets users export recipe cards to other apps. |

## 5.1 Design Style

**Cartoonish neo-brutalism.** Bold flat colors, thick black outlines, chunky drop shadows, exaggerated rounded-but-blocky shapes, and playful illustrated icons (ingredients, utensils, characters). The look should feel fun and approachable rather than sterile or corporate, while still reading as clean and intentional rather than cluttered. This applies across recipe cards, buttons, navigation, and the curated recipe library's visual identity.

## 5.2 App Architecture

Fridgenius\! follows **Flutter's MVVM (Model-View-ViewModel) architecture**, with strict layer separation enforced throughout:

- **Model:** Data classes (recipes, ingredients, user profiles, community posts), built with Freezed for immutability.  
- **View:** UI screens and widgets, kept free of business logic, only responsible for displaying state and forwarding user actions.  
- **ViewModel:** Riverpod providers that hold state, call services (Gemini API, Firestore, Firebase Auth), and expose data to the View.  
- **Service Layer:** Wraps external dependencies (Gemini API calls, Firestore queries, Firebase Auth) so ViewModels never talk to external APIs directly.

This separation keeps the codebase testable and keeps Gemini/Firebase logic isolated from UI changes.

## 6\. Architecture Notes

- **Gemini calls should use structured JSON output mode**, not free-text, so the client can reliably parse recipe title, ingredients, steps, and missing-item flags without brittle string parsing.  
- **Rate limit and cache Gemini calls.** Cache common ingredient combinations client-side or in Firestore to avoid redundant API calls and control cost, since Gemini usage is the main variable expense.  
- **Always pair AI-generated recipes with the curated fallback library.** This protects against hallucinated or unsafe recipe output and gives users a "known good" baseline to compare against.  
- **Don't launch the community feed empty.** Seed it with curated recipes before opening it to real users, so it doesn't look abandoned on day one.

## 7\. Monetization Model

**Primary:** Freemium. Free tier capped at a daily number of Gemini-generated recipes, paid tier removes the cap. This maps the paywall directly to the actual cost driver (API usage).

**Fallback:** Ad-supported tier as an alternative to a hard paywall, useful in price-sensitive markets where subscription conversion tends to be low but ad tolerance is higher.

## 8\. Risks and Mitigations

| Risk | Mitigation |
| :---- | :---- |
| Gemini generates unsafe or nonsensical recipes (wrong proportions, undercooked meat times) | Constrain prompts with strict output schemas and basic food-safety rules. Always offer the curated library as a fallback. |
| Scope creep across three growth loops (share, community, game) | Build and ship Phase 1 fully before starting Phase 2 or 3\. Treat community and game mode as stretch goals, not launch requirements. |
| Empty community feed feels abandoned | Seed the feed with curated content before opening it to real users. |
| Gemini API pricing or rate limits change unexpectedly | Cache common requests and throttle calls to avoid dependency on unlimited free-tier access. |

## 9\. Phased Roadmap

**Phase 1 (Hook):** Ingredient input, Gemini recipe generation, recipe card display, curated fallback library, basic Firebase Auth.

**Phase 2 (Sticky Product):** Favorites/history, shareable recipe cards, near-expiry tagging.

**Phase 3 (Ecosystem):** Community feed, daily Mystery Basket mode.

## 10\. Success Metrics

- Time from app open to first recipe result (target: under 30 seconds, zero config).  
- Percentage of generated recipes saved to favorites (proxy for recipe quality/relevance).  
- Daily/weekly active users once Phase 2 ships (retention signal).  
- Community feed post-to-view ratio once Phase 3 ships (engagement health signal).

