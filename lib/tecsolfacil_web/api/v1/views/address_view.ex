defmodule TecsolfacilWeb.Api.V1.AddressView do
  use TecsolfacilWeb, :view

  def render("address.json", %{address: address}) do
    %{
      cep: address.cep,
      logradouro: address.logradouro,
      complemento: address.complemento,
      bairro: address.bairro,
      localidade: address.localidade,
      uf: address.uf,
      ibge: address.ibge,
      gia: address.gia,
      ddd: address.ddd,
      siafi: address.siafi
    }
  end
end
