defmodule TecsolfacilServices.ViacepClient.Behaviour do
  @callback zip_code_info(integer()) :: {:ok, map()} | {:error, String.t()}
end
