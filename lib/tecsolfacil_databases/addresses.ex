defmodule TecsolfacilDatabases.Addresses do
  @moduledoc """
  Creates all the functions that deals with the Address table
  data.
  """

  alias TecsolfacilDatabases.Addresses.Address
  alias Tecsolfacil.Repo
  alias TecsolfacilServices.ViacepClient.SwitchEnv
  import Ecto.Query

  @doc """
  Return all the addresses structs inside of a list
  """
  @spec list_addresses() :: [Address]
  def list_addresses do
    Repo.all(from u in Address, select: u)
  end

  @spec create_address!(map()) :: Address
  def create_address!(address) do
    %Address{}
    |> Address.changeset(address)
    |> Repo.insert!()
  end

  @doc """
  If the address with the zip_code that was passed as a parameter
  already exists in the database return from there, else gets from
  the API and creates it in the database.
  """
  @spec get_address_by_zip_code(binary()) :: {:ok, Address} | {:error, binary()}
  def get_address_by_zip_code(zip_code) do
    address = get_address_by_zip_code_from_database(zip_code)

    if address do
      {:ok, address}
    else
      get_address_by_zip_code_from_api(zip_code)
    end
  end

  @spec get_address_by_zip_code_from_database(binary()) :: Address | nil
  defp get_address_by_zip_code_from_database(zip_code) do
    Repo.get_by(Address, cep: zip_code)
  end

  @spec get_address_by_zip_code_from_database(binary()) :: {:ok, Address} | {:error, binary()}
  defp get_address_by_zip_code_from_api(zip_code) do
    case SwitchEnv.zip_code_info(zip_code) do
      {:ok, address} ->
        {:ok, create_address!(address)}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
