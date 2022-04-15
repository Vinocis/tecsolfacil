defmodule TecsolfacilWeb.Api.V1.CsvGenViewTest do
  use TecsolfacilWeb.ConnCase
  alias TecsolfacilWeb.Api.V1.CsvGenView

  describe "render/2" do
    test "renders a json to notify the user" do
      file_status = %{file_status: "Arquivo CSV em produção"}

      assert CsvGenView.render("csv.json", file_status) == file_status
    end
  end
end
