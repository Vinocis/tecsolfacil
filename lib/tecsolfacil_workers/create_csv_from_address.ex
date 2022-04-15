defmodule TecsolfacilWorkers.CreateCsvFromAddress do
  @moduledoc """
    The worker that creates the .csv file with all the
    zip code information asynchronously.
  """

  use Oban.Worker,
    queue: :create_csv,
    unique: [period: 1]

  alias TecsolfacilDatabases.Addresses

  @headers [~w/bairro cep complemento ddd gia ibge localidade logradouro siafi uf/]

  @impl Oban.Worker

  @doc """
  Create the .csv file.
  """
  def perform(%Oban.Job{args: %{"file_name" => file_name}}) do
    csv_file =
      prepend_header()
      |> CSV.encode()
      |> Enum.to_list()

    File.write("lib/tecsolfacil/csv/generated_csvs/#{file_name}.csv", csv_file)

    {:ok, csv_file}
  end

  @doc """
    Put the headers at the first line, and the info below.
  """
  def prepend_header do
    addresses = Addresses.list_addresses()

    @headers
    |> Stream.concat(
      Stream.map(
        addresses,
        &[
          &1.bairro,
          &1.cep,
          &1.complemento,
          &1.ddd,
          &1.gia,
          &1.ibge,
          &1.localidade,
          &1.logradouro,
          &1.siafi,
          &1.uf
        ]
      )
    )
  end
end
