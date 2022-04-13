defmodule TecsolfacilServices.ViacepClient.SwitchEnv do
  def zip_code_info(cep), do: client_impl().zip_code_info(cep)

  def client_impl do
    Application.get_env(:tecsolfacil, :switch_env)
  end
end
