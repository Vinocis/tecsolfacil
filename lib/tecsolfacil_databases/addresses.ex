defmodule TecsolfacilDatabases.Addresses do
  alias TecsolfacilDatabases.Addresses.Address
  alias Tecsolfacil.Repo
  alias TecsolfacilServices.ViacepClient.SwitchEnv

  def create_address!(address) do
    %Address{}
    |> Address.changeset(address)
    |> Repo.insert!()
  end

  def get_address_by_zip_code(zip_code) do
    address = get_address_by_zip_code_from_database(zip_code)

    if address do
      {:ok, address}
    else
      get_address_by_zip_code_from_api(zip_code)
    end
  end

  defp get_address_by_zip_code_from_database(zip_code) do
    Repo.get_by(Address, cep: zip_code)
  end

  defp get_address_by_zip_code_from_api(zip_code) do
    case SwitchEnv.zip_code_info(zip_code) do
      {:ok, address} ->
        {:ok, create_address!(address)}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
