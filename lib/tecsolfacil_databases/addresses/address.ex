defmodule TecsolfacilDatabases.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w/cep logradouro complemento bairro localidade uf ibge gia ddd siafi/a

  schema "addresses" do
    field :bairro, :string
    field :cep, :string
    field :complemento, :string
    field :ddd, :string
    field :gia, :string
    field :ibge, :string
    field :localidade, :string
    field :logradouro, :string
    field :siafi, :string
    field :uf, :string

    timestamps()
  end

  def changeset(address, attrs) do
    address
    |> cast(attrs, @fields)
    |> validate_zip_code()
  end

  defp validate_zip_code(changeset) do
    changeset
    |> validate_required(:cep)
    |> remove_mask_from_cep()
    |> validate_length(:cep, is: 8, message: "The zip code should have 8 digits")
    |> unsafe_validate_unique(:cep, Tecsolfacil.Repo,
      message: "This zip code has already been taken"
    )
  end

  defp remove_mask_from_cep(changeset) do
    if get_change(changeset, :cep) do
      zip_code =
        changeset
        |> get_change(:cep)
        |> String.replace(~r/[^\d]/, "")

      put_change(changeset, :cep, zip_code)
    else
      changeset
    end
  end
end
