defmodule TecsolfacilWeb.Api.V1.CsvGenController do
  @moduledoc """
  The controller that deal with the csv route.

  If the user makes a GET request to the addresses/csv
  endpoint, he receives a message to notify him that was a
  successful request and the controller enqueue the job to
  the worker that makes the .csv file
  """

  use TecsolfacilWeb, :controller
  alias Tecsolfacil.Csv.EnqueueToCreate

  def show(conn, _params) do
    EnqueueToCreate.call()

    conn
    |> put_status(:accepted)
    |> render("csv.json", %{file_status: "Arquivo CSV em produção"})
  end
end
