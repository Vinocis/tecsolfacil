defmodule TecsolfacilWeb.Api.V1.CsvGenControllerTest do
  use TecsolfacilWeb.ConnCase
  use Oban.Testing, repo: Tecsolfacil.Repo
  alias TecsolfacilWorkers.CreateCsvFromAddress

  describe "show/2" do
    test "enqueue the job and notify the user", %{conn: conn} do
      file_name =
        NaiveDateTime.local_now()
        |> NaiveDateTime.to_string()
        |> String.replace(~r/[^\d]/, "")

      conn = get(conn, Routes.api_v1_csv_gen_path(conn, :show, []))

      assert_enqueued(
        worker: CreateCsvFromAddress,
        args: %{file_name: file_name}
      )

      assert json_response(conn, 202)["file_status"] == "Arquivo CSV em produção"
    end
  end
end
