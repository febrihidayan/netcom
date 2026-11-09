# Netcom

Laravel 13 + Inertia (Vue) application with CRUD management for e-commerce data (geolocations, customers, sellers, products, orders, etc.).

## Requirements

- PHP >= 8.3 (8.4 recommended)
- Composer
- Node.js >= 18
- PostgreSQL (or MySQL/SQLite)
- Redis (recommended for cache/session/queue)
- Herd (optional, for local `*.test` domain) or any web server

PHP extensions: pdo, pgsql/mysql, mbstring, openssl, tokenizer, xml, ctype, json, bcmath, fileinfo, curl.

## Installation

1. Clone the repository and enter the directory:

```bash
git clone <repo-url> netcom
cd netcom
```

2. Install PHP dependencies:

```bash
composer install
```

3. Install JavaScript dependencies:

```bash
npm install
```

4. Copy environment file and generate app key:

```bash
cp .env.example .env
php artisan key:generate
```

5. Configure database in `.env`:

```env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=netcom
DB_USERNAME=postgres
DB_PASSWORD=secret
```

6. Run migrations and seed sample data:

```bash
php artisan migrate --seed
```

7. Build frontend assets:

```bash
npm run build
```

## Running the Application

### Standard (PHP-FPM / Herd)

Serve with Herd or:

```bash
php artisan serve
```

Open `http://127.0.0.1:8000` or your Herd domain (e.g. `https://netcom.test`).

## Development

Run Vite dev server:

```bash
npm run dev
```

Run tests:

```bash
php artisan test
```

Type-check frontend:

```bash
npm run types:check
```

## Default User

After seeding:

- Email: `admin@app.com`
- Password: `password`

## Notes

- Authentication features are limited to login only (registration, password reset, email verification, 2FA, passkeys disabled).
- All primary keys use UUID except geolocation zip code prefix and product category name.
- Database indexes are included for performance.
- For high traffic, configure Redis and horizontal scaling as described in the codebase notes.

## License

MIT
PHP