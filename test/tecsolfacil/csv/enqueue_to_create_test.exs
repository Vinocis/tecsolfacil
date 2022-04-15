defmodule Tecsolfacil.Csv.EnqueueToCreateTest do
  use Tecsolfacil.DataCase
  use Oban.Testing, repo: Tecsolfacil.Repo
  alias Tecsolfacil.Csv.EnqueueToCreate
  alias TecsolfacilWorkers.CreateCsvFromAddress

  describe "call/0" do
    test "enqueues the job" do
      file_name =
        NaiveDateTime.local_now()
        |> NaiveDateTime.to_string()
        |> String.replace(~r/[^\d]/, "")

      EnqueueToCreate.call()

      assert_enqueued(
        worker: CreateCsvFromAddress,
        args: %{file_name: file_name}
      )
    end
  end
end
