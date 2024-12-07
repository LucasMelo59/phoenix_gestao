defmodule PhoenixGestao.Despesas do
  import Ecto.Query, only: [from: 2, order_by: 2, limit: 2, fragment: 2]

  @moduledoc """
  The Despesas context.
  """

  alias PhoenixGestao.Repo
  alias PhoenixGestao.Despesas.Despesa

  @doc """
  Returns the list of despesas.

  ## Examples

      iex> list_despesas()
      [%Despesa{}, ...]

  """
  def list_despesas do
    Repo.all(Despesa)
  end

  @doc """
  Gets a single despesa.

  Raises `Ecto.NoResultsError` if the Despesa does not exist.

  ## Examples

      iex> get_despesa!(123)
      %Despesa{}

      iex> get_despesa!(456)
      ** (Ecto.NoResultsError)

  """
  def get_despesa!(id), do: Repo.get!(Despesa, id)

  @doc """
  Creates a despesa.

  ## Examples

      iex> create_despesa(%{field: value})
      {:ok, %Despesa{}}

      iex> create_despesa(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_despesa(attrs \\ %{}) do
    %Despesa{}
    |> Despesa.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a despesa.

  ## Examples

      iex> update_despesa(despesa, %{field: new_value})
      {:ok, %Despesa{}}

      iex> update_despesa(despesa, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_despesa(%Despesa{} = despesa, attrs) do
    despesa
    |> Despesa.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a despesa.

  ## Examples

      iex> delete_despesa(despesa)
      {:ok, %Despesa{}}

      iex> delete_despesa(despesa)
      {:error, %Ecto.Changeset{}}

  """
  def delete_despesa(%Despesa{} = despesa) do
    Repo.delete(despesa)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking despesa changes.

  ## Examples

      iex> change_despesa(despesa)
      %Ecto.Changeset{data: %Despesa{}}

  """
  def change_despesa(%Despesa{} = despesa, attrs \\ %{}) do
    Despesa.changeset(despesa, attrs)
  end

   def list_mes(month) do
    month = if is_binary(month), do: String.to_integer(month), else: month

    from(e in Despesa,
      where: fragment("EXTRACT(MONTH FROM ?)", e.data) == ^month
    )
    |> Repo.all()
  end

  # Função para listar despesas por período
  def list_period(start_date, end_date) do
    from(e in Despesa,
      where: e.data >= ^start_date and e.data <= ^end_date
    )
    |> Repo.all()
  end

  # Listar as maiores despesas
def list_maior(:desc) do
  from(e in Despesa,
    order_by: [desc: e.valor],
    limit: 10
  )
  |> Repo.all()
end

# Listar as menores despesas
def list_menor(:asc) do
  from(e in Despesa,
    order_by: [asc: e.valor],
    limit: 10
  )
  |> Repo.all()
end


end
