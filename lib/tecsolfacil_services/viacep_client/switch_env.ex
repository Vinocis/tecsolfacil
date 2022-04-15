defmodule TecsolfacilServices.ViacepClient.SwitchEnv do
  @moduledoc """
  Based on the environment, switches between the Mock module
  and the real module that gets the zip code info from the API
  """
  def zip_code_info(cep), do: client_impl().zip_code_info(cep)

  def client_impl do
    Application.get_env(:tecsolfacil, :switch_env)
  end
end
