# FlowBoard - Underlying Features

## Backend (Rails 8 API)

- **Trick Management**

  - Preloaded tricks using **seeds**.
  - Each trick includes:
    - Name
    - Description
    - Difficulty level (_Beginner, Intermediate, Advanced_)
    - Estimated learning time
    - Categories/tags (_Spin, Slide, Footwork, etc._)
    - Video URL (_YouTube, Vimeo, etc._)

- **Public API to Retrieve Tricks**

  - **Endpoint**: `GET /figures`

- **Trick Recommendation System**

  - **Endpoint**: `GET /recommendations`
  - **Authentication required**

- **User Authentication**

  - Sign up and login
  - Token-based authentication

- **Testing and Quality Assurance**
  - **RSpec tests** for API endpoints and recommendation algorithm

---

## Frontend (Vue.js 3 + TypeScript)

- **User Forms**

  - Sign Up
  - Login
  - FlowBoard Form (_Select skill level, session duration, mastered tricks_)

- **Trick List Page**

  - Displays all tricks from the database
  - **Category filters** for sorting

- **Recommendation Page**

  - Displays suggested tricks

- **User Interface**
  - **Responsive** using **Tailwind CSS**

---

## Bonus / Possible Improvements

## Running the Project Locally

1. Clone the repository :

2. To launch the project in a local environment, use the following command:

`docker-compose -f docker-compose.dev.yml exec web bin/rails db:migrate`

`docker-compose -f docker-compose.dev.yml up --build -d`

3. Backend logs :

`docker-compose -f docker-compose.dev.yml logs backend`

4. Frontend logs :

`docker-compose -f docker-compose.dev.yml logs frontend`

4. Migrations in Docker

`docker-compose -f docker-compose.dev.yml exec backend bundle exec rails db:migrate`

5. Routes :

`http://localhost:5173` => Home
`http://localhost:5173/figures` => Tricks
`http://localhost:5173/dashboard` => User dashboard
