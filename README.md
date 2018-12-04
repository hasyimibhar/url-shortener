## Development

### Locally

1. Setup Postgres. The easiest way is to use Docker. The command below will start a detached Postgres container:

    ```sh
    $ docker run -it --rm -d \
        -p 5432:5432 \
        -v "$(pwd)/tmp/db:/var/lib/postgresql/data" \
        postgres
    ```

2. Setup gems:

    ```sh
    $ bundle
    ```

3. Setup environment variables:

    ```sh
    $ cp .env.example .env
    ```

4. Create the databases:

    ```sh
    $ rake db:create
    ```

4. Start the app:

    ```sh
    $ bundle exec rails server
    ```

### Using Docker Compose

1. Start the containers using Docker Compose:

    ```sh
    $ docker-compose up
    ```

2. Create the database if it has not been created yet (you only need to do this once). In another terminal, run:

    ```sh
    $ docker-compose run web rake db:create
    ```

3. The app is now available at http://localhost:3000.

## Tests

To run tests:

```sh
$ bundle exec rspec
```
