# SeoulStyle AI — Project Overview (PDR)

This document provides the high-level overview, product requirements, and business goals for the SeoulStyle AI mobile application.

---

## 🎯 Target & Demo Objectives
The application is designed as a university graduation demo project showcasing Korean-style fashion shopping. The core objectives are:
1. **Highlighting Personalization**: Demonstrating that AI can simplify the search experience by matching user preferences to clothing recommendations.
2. **Localization**: Showcasing full support for Vietnamese, Korean, and English users without hardcoding assets.
3. **Immersive Shopping Journey**: Delivering a complete flow from product discovery, size selection, dynamic cart actions, checkout, simulated payment processing, and order history.

---

## 👥 Target Demographics
* Tech-savvy college students or young adults interested in Korean fashion trends.
* International audiences in Vietnam, South Korea, and English-speaking locales.

---

## 🔒 Constraints
* **Mock Local Data**: Operates offline using local JSON data assets (no network latency).
* **Local Persistence**: Sessions and checkouts are saved inside SharedPreferences (cleared upon app deletion/logout).
* **Portrait Only**: Lock orientation to portrait mode.
