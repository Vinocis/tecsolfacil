defmodule TecsolfacilServices.ViacepClient.Behaviour do
  @moduledoc """
  Behaviour of the ViacepClient.Impl
  """
  @callback zip_code_info(integer()) :: {:ok, map()} | {:error, String.t()}
end
