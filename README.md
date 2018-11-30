## Development

### Using Docker

1. Start the containers using Docker Compose:

    ```sh
    docker-compose up
    ```

2. Create the database if it has not been created yet (you only need to do this once). In another terminal, run:

    ```sh
    docker-compose run web rake db:create
    ```

3. The app is now available at http://localhost:3000.