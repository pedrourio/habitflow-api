# HabitFlow API 🚀

API backend para a aplicação HabitFlow, um rastreador de hábitos. Construída com Ruby on Rails, esta API segue uma arquitetura API-First, servindo dados em formato JSON para qualquer cliente, seja web ou mobile.

---

### ✨ Principais Funcionalidades

* **Autenticação Segura:** Sistema de registro e login com tokens **JWT** (JSON Web Tokens), utilizando a gem Devise.
* **CRUD de Hábitos:** Endpoints completos para Criar, Ler, Atualizar e Apagar hábitos, sempre no escopo do usuário autenticado.
* **CRUD de Check-ins:** Endpoints aninhados para registrar e remover o progresso diário de um hábito.
* **Gerenciamento de Perfil:** Endpoint para o usuário visualizar e atualizar suas próprias informações.

---

### 🛠️ Tecnologias e Arquitetura

* **Ruby on Rails 8** (modo API-Only)
* **PostgreSQL** como banco de dados
* **Puma** como servidor web
* **Devise & Devise-JWT** para autenticação stateless
* **RSpec** para a suíte de testes
* **Docker** para um ambiente de desenvolvimento padronizado com PostgreSQL

---

### 📚 Documentação da API

A API está versionada e disponível sob o caminho `/api/v1/`. Todas as requisições (exceto login/cadastro) exigem um `Bearer Token` no cabeçalho `Authorization`.

| Verbo | Endpoint | Protegido? | Descrição |
| :--- | :--- | :--- | :--- |
| **Autenticação** | | | |
| `POST` | `/signup` | Não | Cria um novo usuário. |
| `POST` | `/login` | Não | Autentica um usuário e retorna um token JWT. |
| `DELETE` | `/logout`| Sim | Invalida o token JWT do usuário. |
| **Hábitos** | | | |
| `GET` | `/api/v1/habits` | Sim | Lista todos os hábitos do usuário logado. |
| `POST` | `/api/v1/habits` | Sim | Cria um novo hábito. |
| `PUT/PATCH` | `/api/v1/habits/:id` | Sim | Atualiza um hábito existente. |
| `DELETE` | `/api/v1/habits/:id` | Sim | Apaga um hábito. |
| **Check-ins** | | | |
| `POST` | `/api/v1/habits/:id/checkins` | Sim | Cria um check-in para um hábito em uma data. |
| **Perfil** | | | |
| `GET` | `/api/v1/profile` | Sim | Retorna os dados do usuário logado. |
| `PUT/PATCH` | `/api/v1/profile` | Sim | Atualiza os dados do usuário logado. |

---

### 🚀 Começando (Setup Local)

1.  **Pré-requisitos:** Ruby (via `rbenv`), Bundler e Docker instalados.
2.  Clone o repositório: `git clone https://github.com/[seu-usuario]/habitflow-api.git`
3.  Instale as dependências: `bundle install`
4.  Inicie o banco de dados PostgreSQL com Docker: `docker compose up -d`
5.  Crie e configure o arquivo de credenciais para o segredo do JWT:
    ```bash
    EDITOR="code --wait" bin/rails credentials:edit
    ```
    E adicione a linha: `devise_jwt_secret_key: 'COLE_AQUI_UMA_CHAVE_GERADA_COM_RAILS_SECRET'`
6.  Crie e migre o banco de dados: `bin/rails db:create db:migrate`
7.  Inicie o servidor: `bin/rails s`

A API estará disponível em `http://localhost:3000`.

---

### 👨‍💻 Autor

* **[Pedro Urio]** - [https://www.linkedin.com/in/pedro-henrique-u-4476aa257/]

---

### 📄 Licença

Este projeto está sob a licença MIT.
