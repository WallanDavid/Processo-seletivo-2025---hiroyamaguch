**Processo Seletivo 2025 – Whitelabel E-commerce**

- Frontend: Flutter Web (login, listagem e filtro de produtos, whitelabel via host ou seleção manual).
- Backend: NestJS (manual setup) com módulos Auth, Clients e Products; proxy para fornecedores.

**Como rodar**
- Backend:
  - `cd backend`
  - `npm install`
  - `npm run build`
  - `npm run start` → `http://localhost:3000/`
- Frontend (Web):
  - `cd frontend`
  - `flutter pub get`
  - `flutter run -d web-server --web-hostname localhost --web-port 5174` → `http://localhost:5174/`

**Login**
- Usuário seed: `admin@in8.com.br`
- Senha: `admin123`

**Whitelabel**
- Clientes seed:
  - `brazil.in8.local` → fornecedor brasileiro
  - `europe.in8.local` → fornecedor europeu
- Em ambiente local, selecione o cliente no dropdown da tela de Produtos.
- Opcionalmente configure `C:\Windows\System32\drivers\etc\hosts`:
  - `127.0.0.1 brazil.in8.local`
  - `127.0.0.1 europe.in8.local`

**API**
- `POST /auth/login` → retorna `accessToken` (não exigido nos demais endpoints neste MVP).
- `GET /clients` → lista clientes whitelabel.
- `GET /products?search=&client=` → lista produtos com filtro e origem do fornecedor por cliente.
- `GET /products/:id?client=` → detalhe do produto.

Documentação adicional em `backend/README.md` e `backend/docs/architecture.md`. Collection Postman em `backend/postman/collection.json`.
