defmodule TecsolfacilWorkers.CreateCsvFromAddressTest do
  use Tecsolfacil.DataCase
  use Oban.Testing, repo: Tecsolfacil.Repo
  alias TecsolfacilWorkers.CreateCsvFromAddress

  describe "perform/1" do
    test "success when the user exists" do
      file_name =
        NaiveDateTime.local_now()
        |> NaiveDateTime.to_string()
        |> String.replace(~r/[^\d]/, "")

      assert {:ok, _} =
               perform_job(CreateCsvFromAddress, %{
                 file_name: file_name
               })
    end
  end
end
