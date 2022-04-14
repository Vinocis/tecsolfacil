defmodule TecsolfacilWeb.Api.V1.CsvGenView do
  use TecsolfacilWeb, :view

  def render("csv.json", %{file_status: file_status}) do
    %{file_status: file_status}
  end
end
