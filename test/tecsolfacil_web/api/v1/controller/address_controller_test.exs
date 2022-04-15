defmodule TecsolfacilWeb.Api.V1.AddressControllerTest do
  use TecsolfacilWeb.ConnCase
  alias TecsolfacilDatabases.Addresses
  import Mox

  @valid_address %{
    bairro: "bairro",
    cep: "01001000",
    localidade: "localidade",
    logradouro: "logradouro",
    uf: "uf"
  }

  describe "show/2" do
    test "if exists, get the address from the database and show it", %{conn: conn} do
      Addresses.create_address!(@valid_address)
      conn = get(conn, Routes.api_v1_address_path(conn, :show, @valid_address.cep))

      assert json_response(conn, 200)["cep"] == @valid_address.cep
    end

    test "if doesn't exists in the database, get the address from the api and show it", %{
      conn: conn
    } do
      expect(ViacepClientMock, :zip_code_info, fn zip_code ->
        assert zip_code == @valid_address.cep

        {:ok,
         %{
           bairro: "bairro",
           cep: "01001-000",
           localidade: "localidade",
           logradouro: "logradouro",
           uf: "uf"
         }}
      end)

      conn = get(conn, Routes.api_v1_address_path(conn, :show, @valid_address.cep))

      assert json_response(conn, 200)["cep"] == @valid_address.cep
    end

    # test "if doesn't exists in the database, get the address from the api and show it", %{conn: conn} do
    #   expect(ViacepClientMock, :zip_code_info, fn zip_code ->
    #     assert zip_code == "00000-000"

    #     {:error, }
    #   end)

    #   conn =
    #     get(conn, Routes.api_v1_address_path(conn, :show, @valid_address.cep))

    #   assert json_response(conn, 200)["cep"] == @valid_address.cep
    # end
  end
end
