defmodule TecsolfacilServices.ViacepClient.CepSwitchTest do
  alias TecsolfacilServices.ViacepClient.SwitchEnv
  use ExUnit.Case
  import Mox

  describe "zip_code_info/1" do
    test "if exists, return the zip code info" do
      expect(ViacepClientMock, :zip_code_info, fn zip_code ->
        assert zip_code == "01001-000"

        {:ok,
         %{
           bairro: "bairro",
           cep: "01001-000",
           localidade: "localidade",
           logradouro: "logradouro",
           uf: "uf"
         }}
      end)

      assert {:ok, _} = SwitchEnv.zip_code_info("01001-000")
    end

    test "fails if the zip code doesn't exist" do
      expect(ViacepClientMock, :zip_code_info, fn zip_code ->
        assert zip_code == "00000-000"

        {:error, "CEP não encontrado"}
      end)

      assert {:error, "CEP não encontrado"} = SwitchEnv.zip_code_info("00000-000")
    end

    test "fails if the zip code is invalid" do
      expect(ViacepClientMock, :zip_code_info, fn zip_code ->
        assert zip_code == "00000-0000"

        {:error, "CEP inválido"}
      end)

      assert {:error, "CEP inválido"} = SwitchEnv.zip_code_info("00000-0000")
    end
  end
end
