defmodule PhoenixGestao.Receitas.Receita do
  use Ecto.Schema
  import Ecto.Changeset

  schema "receitas" do
    field :descricao, :string
    field :valor, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(receita, attrs) do
    receita
    |> cast(attrs, [:descricao, :valor])
    |> validate_required([:descricao, :valor])
  end
end
