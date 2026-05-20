# Lexa POS

Professional tablet point-of-sale (POS) for merchants — landscape-first, offline-capable core.

## Local database (offline)

The app uses **[Drift](https://drift.simonbinder.eu/)** on **[SQLite](https://www.sqlite.org/)** for on-device storage:

- **No hosting required** for UMKM — data lives on the tablet until you add sync later.
- **Relational model** that maps cleanly to **PostgreSQL / MySQL** if an enterprise client needs a central server.
- Schema entry point: [`lib/core/database/app_database.dart`](lib/core/database/app_database.dart).

Tables in v1:

- `products` — catalog (price in whole Rupiah `int`, stock, category, sync timestamp).
- `sync_outbox` — queue for future API sync (payload JSON).

Domain access goes through repositories (e.g. [`ProductCatalogRepository`](lib/features/catalog/domain/repositories/product_catalog_repository.dart)) so you can swap SQLite for a remote implementation without rewriting UI.

## Code generation

After changing Drift tables or Widgetbook use cases:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Running the app

From project root (if Flutter reports a git `safe.directory` error for the SDK, set `GIT_CONFIG_*` env vars as in `scripts/run_dev.ps1`):

```powershell
flutter run
```

Widgetbook (design system only):

```powershell
flutter run -t lib/main_widgetbook.dart
```

## Auth demo accounts

| Role    | Email            | Password   | PIN  |
| ------- | ---------------- | ---------- | ---- |
| Cashier | cashier@lexa.pos | cashier123 | 1234 |
| Manager | manager@lexa.pos | manager123 | 5678 |
| Owner   | owner@lexa.pos   | owner123   | 9999 |
