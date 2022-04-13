defmodule TecsolfacilServices.ViacepClient.Impl do
  alias TecsolfacilServices.ViacepClient.Behaviour

  @behaviour Behaviour

  @impl Behaviour
  def zip_code_info(zip_code) do
    :get
    |> Finch.build("https://viacep.com.br/ws/#{zip_code}/json/")
    |> Finch.request(CepFinch)
    |> handle_response()
  end

  def handle_response({:ok, %{body: body, status: 200}}) do
    body = Jason.decode!(body)

    if Map.get(body, "erro") do
      {:error, "CEP não encontrado"}
    else
      {:ok, body}
    end
  end

  def handle_response({:ok, %{status: _status}}) do
    {:error, "CEP inválido"}
  end
end
