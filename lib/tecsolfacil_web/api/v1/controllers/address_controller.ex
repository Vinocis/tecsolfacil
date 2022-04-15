defmodule TecsolfacilWeb.Api.V1.AddressController do
  use TecsolfacilWeb, :controller
  alias TecsolfacilDatabases.Addresses

  def show(conn, %{"cep" => cep}) do
    address = Addresses.get_address_by_zip_code(cep)

    case address do
      {:ok, address} ->
        render(conn, "address.json", address: address)

      {:error, reason} ->
        send_resp(conn, 400, reason)
    end
  end
end
