defmodule PhoenixGestao.Despesas.Despesa do
  use Ecto.Schema
  import Ecto.Changeset

  schema "despesas" do
    field :descricao, :string
    field :valor, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(despesa, attrs) do
    despesa
    |> cast(attrs, [:descricao, :valor])
    |> validate_required([:descricao, :valor])
  end
end
