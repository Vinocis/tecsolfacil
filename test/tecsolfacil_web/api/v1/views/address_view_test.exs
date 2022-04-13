defmodule TecsolfacilWeb.Api.V1.AddressViewTest do
  use TecsolfacilWeb.ConnCase
  alias TecsolfacilWeb.Api.V1.AddressView
  import Phoenix.View

  describe "render/2" do
    test "if an address is given, renders a json with their information" do
      address =
        %{
          bairro: "bairro",
          cep: "01001000",
          complemento: "complemento",
          ddd: "00",
          gia: "0000",
          ibge: "0000000",
          localidade: "localidade",
          logradouro: "logradouro",
          siafi: "0000",
          uf: "uf"
        }

        assert AddressView.render("address.json", address: address) == address
    end
  end
end
