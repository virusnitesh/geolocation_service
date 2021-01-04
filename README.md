# geolocation_service

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Setting up Application environment

  * Need to define file path location using which module will seed the data
  * To run import we have to run `GeolocationService.Apicontext.seed_geo_location_data()` in console mode
  * Haven't added cron but we can perfom the same operation using cron
  * After running phoenix server we need to `http://localhost:4000/search_geo_data` use this URL and perform search operation based on UI.