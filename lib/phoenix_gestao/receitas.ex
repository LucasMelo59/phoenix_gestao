defmodule PhoenixGestao.Receitas do
  @moduledoc """
  The Receitas context.
  """

import Ecto.Query, only: [from: 2, order_by: 2, limit: 2, fragment: 2]
alias PhoenixGestao.Repo

  alias PhoenixGestao.Receitas.Receita

  @doc """
  Returns the list of receitas.

  ## Examples

      iex> list_receitas()
      [%Receita{}, ...]

  """
  def list_receitas do
    Repo.all(Receita)
  end

  @doc """
  Gets a single receita.

  Raises `Ecto.NoResultsError` if the Receita does not exist.

  ## Examples

      iex> get_receita!(123)
      %Receita{}

      iex> get_receita!(456)
      ** (Ecto.NoResultsError)

  """
  def get_receita!(id), do: Repo.get!(Receita, id)

  @doc """
  Creates a receita.

  ## Examples

      iex> create_receita(%{field: value})
      {:ok, %Receita{}}

      iex> create_receita(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_receita(attrs \\ %{}) do
    %Receita{}
    |> Receita.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a receita.

  ## Examples

      iex> update_receita(receita, %{field: new_value})
      {:ok, %Receita{}}

      iex> update_receita(receita, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_receita(%Receita{} = receita, attrs) do
    receita
    |> Receita.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a receita.

  ## Examples

      iex> delete_receita(receita)
      {:ok, %Receita{}}

      iex> delete_receita(receita)
      {:error, %Ecto.Changeset{}}

  """
  def delete_receita(%Receita{} = receita) do
    Repo.delete(receita)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking receita changes.

  ## Examples

      iex> change_receita(receita)
      %Ecto.Changeset{data: %Receita{}}

  """
  def change_receita(%Receita{} = receita, attrs \\ %{}) do
    Receita.changeset(receita, attrs)
  end

  def list_mes(month) do
    month = if is_binary(month), do: String.to_integer(month), else: month

    from(e in Receita,
      where: fragment("EXTRACT(MONTH FROM ?)", e.date) == ^month
    )
    |> Repo.all()
  end

  # Função para listar despesas por período
  def list_period(start_date, end_date) do
    from(e in Receita,
      where: e.data >= ^start_date and e.data <= ^end_date
    )
    |> Repo.all()
  end

  # Listar as maiores receitas
def list_maior(:desc) do
  from(e in Receita,
    order_by: [desc: e.valor],
    limit: 10
  )
  |> Repo.all()
end

# Listar as menores receitas
def list_menor(:asc) do
  from(e in Receita,
    order_by: [asc: e.valor],
    limit: 10
  )
  |> Repo.all()
end
end
