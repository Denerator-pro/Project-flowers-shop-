# Flower Shop (HTML + CSS + JS + PHP + AJAX)

MVP интернет-магазина цветов с регистрацией, входом и админ-панелью.

## Стек

- `HTML` - структура страницы (`public/index.php`)
- `CSS` - внешний вид (`public/assets/css/style.css`)
- `JS` - интерактивность и AJAX (`public/assets/js/app.js`)
- `PHP` - API и бизнес-логика (`public/api.php`, `src/*.php`)
- `AJAX` - клиент-серверная связь через `fetch`

## Функциональность

- Каталог товаров, фильтрация, корзина и оформление заказа.
- Регистрация и вход пользователей.
- Роли `user/admin`.
- Админ-панель:
  - просмотр зарегистрированных пользователей;
  - назначение админов из списка пользователей;
  - смена паролей админов;
  - добавление новых товаров;
  - изменение цен товаров.

## Дефолтный админ

Если в системе нет ни одного администратора, создается аккаунт:

- `email`: `admin@flowershop.local`
- `password`: `Admin123!`

После входа рекомендуется сразу сменить пароль через админ-панель.

## Структура проекта

```text
public/
  index.php
  api.php
  assets/
    css/style.css
    js/app.js
src/
  bootstrap.php
  Response.php
  Security.php
  Validator.php
  FlowerRepository.php
  CartService.php
  OrderService.php
  UserRepository.php
storage/
  flowers.json
  users.json
  orders.log
```

## API (action)

- `GET api.php?action=products`
- `GET api.php?action=cart`
- `GET api.php?action=auth_status`
- `GET api.php?action=admin_users` (admin)
- `POST api.php?action=register`
- `POST api.php?action=login`
- `POST api.php?action=logout`
- `POST api.php?action=cart_add`
- `POST api.php?action=cart_remove`
- `POST api.php?action=checkout`
- `POST api.php?action=admin_make_admin` (admin)
- `POST api.php?action=admin_change_password` (admin)
- `POST api.php?action=admin_add_product` (admin)
- `POST api.php?action=admin_update_price` (admin)

## Безопасность (базовая)

- CSRF-защита для всех `POST`-эндпоинтов.
- Валидация и фильтрация входных данных на сервере.
- Хеширование паролей через `password_hash`.
- Проверка ролей для админ-операций.
- Security headers: `CSP`, `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`.
- Rate limit на чувствительные действия (`register/login/checkout`).
- `HttpOnly` + `SameSite=Lax` для cookie сессии.

## Запуск

```powershell
.\start-server.ps1
```

Открыть: `http://127.0.0.1:8080`

Остановка:

```powershell
.\stop-server.ps1
```
