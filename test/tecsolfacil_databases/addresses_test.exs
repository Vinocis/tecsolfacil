defmodule TecsolfacilDatabases.AddressesTest do
  use Tecsolfacil.DataCase
  alias TecsolfacilDatabases.Addresses
  import Mox

  @valid_address %{
    bairro: "bairro",
    cep: "01001000",
    localidade: "localidade",
    logradouro: "logradouro",
    uf: "uf"
  }

  describe "create_address/1" do
    test "pass with valid arguments" do
      address = Addresses.create_address!(@valid_address)

      assert address.cep == @valid_address.cep
    end

    test "fails with invalid arguments" do
      assert_raise Ecto.CastError, fn -> Addresses.create_address!([]) end
      assert_raise Ecto.InvalidChangesetError, fn -> Addresses.create_address!(%{}) end

      assert_raise Ecto.InvalidChangesetError, fn ->
        Addresses.create_address!(Map.delete(@valid_address, :cep))
      end
    end
  end

  describe "get_address_by_zip_code/1" do
    test "return the zip code info if exists in the database" do
      Addresses.create_address!(@valid_address)

      assert {:ok, _} = Addresses.get_address_by_zip_code(@valid_address.cep)
    end

    test "if the zip code doesn't exists in the database create it from api" do
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

      assert {:ok, _} = Addresses.get_address_by_zip_code(@valid_address.cep)
    end

    test "fails if the zip code doesn't exists in the api neither in the database" do
      expect(ViacepClientMock, :zip_code_info, fn zip_code ->
        assert zip_code == "00000-000"

        {:error, "CEP não encontrado"}
      end)

      assert {:error, "CEP não encontrado"} = Addresses.get_address_by_zip_code("00000-000")
    end

    test "fails if the zip code is invalid" do
      expect(ViacepClientMock, :zip_code_info, fn zip_code ->
        assert zip_code == "00000-0000"

        {:error, "CEP inválido"}
      end)

      assert {:error, "CEP inválido"} = Addresses.get_address_by_zip_code("00000-0000")
    end
  end
end
