defmodule TecsolfacilWorkers.CreateCsvFromAddressTest do
  use Tecsolfacil.DataCase
  use Oban.Testing, repo: Tecsolfacil.Repo
  alias TecsolfacilWorkers.CreateCsvFromAddress

  describe "perform/1" do
    test "success when the user exists" do
      assert {:ok, _} =
               perform_job(CreateCsvFromAddress, %{
                 file_name: "file_name"
               })
    end
  end
end
