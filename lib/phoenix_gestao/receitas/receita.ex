defmodule PhoenixGestao.Receitas.Receita do
  use Ecto.Schema
  import Ecto.Changeset

  schema "receitas" do
    field :descricao, :string
    field :valor, :decimal
    field :data, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(receita, attrs) do
    receita
    |> cast(attrs, [:descricao, :valor])
    |> validate_required([:descricao, :valor])
    |> put_default_date()
  end

  defp put_default_date(changeset) do
    case get_change(changeset, :data) do
      nil -> put_change(changeset, :data, Date.utc_today())
      _ -> changeset
    end
  end
end
