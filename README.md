# Assignment: Flutter CRUD Application

## Student Information
* **Name:** Selam Tewodros
* **Student ID:** ugr/2331/16
* **Project Name:** Selina Coffee House
*
# Selina Coffee House ☕

An advanced Flutter CRUD application built using Feature-First Clean Architecture and professional state management tools.

## 🚀 Architectural & Package Breakdown
* **State Management:** Flutter BLoC Pattern (Events & States)
* **Network Client:** Dio Package (Handling live queries)
* **Public Data Source:** JSONPlaceholder API Integration
* **Theme & Customization:** Localized currency formatting (ETB) and clean, responsive UI menus

---

## 📸 Application Walkthrough & Screenshots

### 1. Main Menu (Read Operation via Dio)
The application dynamically pulls live mock resources from the JSONPlaceholder API endpoint using the Dio package and presents a beautifully organized menu displaying pricing in Ethiopian Birr (ETB).

<img width="1280" height="886" alt="home" src="https://github.com/user-attachments/assets/66160c9c-bfec-40e6-97c6-a27699542a50" />

### 2. Add New Coffee Item (Create Operation)
Clicking the floating action button launches a custom modal sheet allowing users to input and register a brand-new coffee item directly into the active state layer.

<img width="1250" height="849" alt="add_coffee" src="https://github.com/user-attachments/assets/4757e4e0-8098-4e03-a678-1bbbe3149c49" />

### 3. Modify Menu Item (Update Operation)
Selecting an item's edit button safely triggers a pre-populated state injection overlay, allowing real-time modifications to the selected drink's features and pricing.

<img width="1275" height="862" alt="edit" src="https://github.com/user-attachments/assets/202f816a-dd45-45b6-9f07-cb65178e07a6" />

### 4. Delete Confirmation Shield (Safety Handling)
To protect application state data from accidental losses, the delete workflow is secured behind a defensive confirmation alert dialog layout.

<img width="1210" height="839" alt="delete_confirm" src="https://github.com/user-attachments/assets/bbecde87-a121-4a90-b963-0e7252d575ed" />
