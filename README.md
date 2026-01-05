# PokéDeck: A 1-week study project to practice TCA basics.

A native iOS Pokémon library application exploring the intersection of **strict state management (TCA)** and **industrial design principles** (Tactile UX).

[![Behance](https://img.shields.io/badge/Behance-View%20Case%20Study-0056FF?style=for-the-badge&logo=behance&logoColor=white)](https://www.behance.net/gallery/241507685/PokDeck-Native-iOS-App-(SwiftUI-TCA-Haptics))

### 📱 App Demo

<!-- Replace 'demo_swipe.gif' and 'demo_random.gif' with your actual file paths -->
<p align="center">
  <img src="https://github.com/user-attachments/assets/bf6fb266-35dc-415b-9bf1-7a17d916fafc" width="45%" />
  <img src="https://github.com/user-attachments/assets/a32df44c-c0ce-4619-b303-279ee4b5bb21" width="45%" />
</p>

---

## 🚀 Key Features & Tech Highlights

Bridging the gap between software architecture and physical product design.

### 🏗 Strict State Management (TCA)
- Built with **The Composable Architecture (1.7+)** to ensure predictable state mutations.
- **Challenge:** Managing complex side effects (API chaining, random generation) while keeping the view logic pure.
- **Solution:** Implemented robust `Reducers` and `Effects` to handle async network requests (`URLSession`) and state synchronization deterministically.

### 📳 Digital Tactility (Industrial Design UX)
- Engineered a "Physical" user experience by leveraging my industrial design background.
- **Implementation:** Synced **Core Haptics** (`UIImpactFeedbackGenerator`) precisely with TCA state changes.
- **Result:** Every swipe and button press provides "weight" and "texture," creating a mechanical feel rarely found in standard apps.

### 🎨 Native Polish & Layout
- **Visual Hierarchy:** Utilized `ZStack` layering to create depth between the watermark (#025), the placeholder skeleton, and the real card content.
- **Performance:** Optimized `TabView` for smooth 120Hz ProMotion scrolling with efficient memory management for infinite paging.

---

## 🛠 Tech Stack

- **Language:** Swift 5
- **Architecture:** The Composable Architecture (TCA)
- **UI Framework:** SwiftUI
- **Networking:** URLSession, Async/Await, Codable
- **UX Engineering:** Core Haptics (UIKit Integration), Combine

---

## 🇯🇵 日本語 (Japanese)

**概要:**
TCA (The Composable Architecture) の厳密な状態管理と、工業デザインの知見を融合させたポケモン図鑑アプリです。「デジタル体験に物理的な重みを与える」ことをテーマに開発しました。

**主な技術的取り組み:**

* **TCAによる堅牢な設計:**
    最新のTCA (1.7+) を採用し、単方向データフロー（Unidirectional Data Flow）を構築。複雑なAPI通信や非同期処理を`Effect`として分離し、テスト容易性とロジックの純粋性を担保しました。

* **「手触り」のエンジニアリング:**
    工業デザイナーとしての背景を活かし、UI操作に「物理的な質感」を実装。TCAのState変化に合わせて`UIImpactFeedbackGenerator`（Haptics）を精密に同期させ、ボタンの重みやカードの摩擦感を表現しました。

* **ネイティブUIの洗練:**
    `ZStack`を用いたレイヤー構造により、データの読み込み待機時（スケルトン表示）から表示完了までの遷移をシームレスに実装。`TabView`の挙動を最適化し、滑らかなページング体験を実現しました。

---

## 🇨🇳 中文 (Chinese)

**项目简介:**
一款结合了 **TCA 架构**（严格状态管理）与**工业设计理念**（触感交互）的 iOS 宝可梦图鉴应用。

**核心亮点:**
* **架构实践 (TCA):** 采用 The Composable Architecture (1.7+) 构建单向数据流，将副作用（Side Effects）与 UI 逻辑严格分离，确保了状态变更的可预测性。
* **数字化触感 (Digital Tactility):** 结合工业设计背景，利用 TCA 状态变化的确定性，精准同步触觉反馈 (`Core Haptics`)，为简单的滑动和点击赋予了“机械般”的物理质感。
* **原生体验打磨:** 深度定制 SwiftUI `TabView` 和 `ZStack` 布局，实现了带有巨大水印编号和骨架屏过渡的流畅分页效果。
