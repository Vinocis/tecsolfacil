# Tecsolfacil

## About the code

Consumes the [`ViaCep`](https://viacep.com.br) web service to get the information from a specific zip code, populate the database with that info, and finally create a .csv file with all the database information.


## How to use

First of all, make sure to have the 1.12 elixir version installed.

Now that you have the Elixir on your machine, lets get it started!

  * Install dependencies with `mix deps.get`
  * Create and migrate the database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

After this 3 simple commands, you have 2 options:
  * [`localhost:4000/address/:zip_code`](http://localhost:4000/address/:zip_code)
  Here you can search and get how many zip code informations that you want
  * [`localhost:4000/addresses/csv`](http://localhost:4000/addresses/csv)
  By accessing this endpoint our application will generate the .csv file

Greatly recommend populating your database before accessing the second endpoint. But no problem if you don't, the file will just have the headers and nothing more.

All the files that you create will be in this path: `lib/tecsolfacil/csv/generated_csvs/file_name.csv`

## Contributing

If you see something that can improve or any errors, feel free to make a pull request or open an issue.

See ya!