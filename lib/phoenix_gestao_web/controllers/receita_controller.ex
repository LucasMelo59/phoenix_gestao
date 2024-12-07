defmodule PhoenixGestaoWeb.ReceitaController do
  use PhoenixGestaoWeb, :controller

  alias PhoenixGestao.Receitas
  alias PhoenixGestao.Receitas.Receita


  def new(conn, _params) do
    changeset = Receitas.change_receita(%Receita{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"receita" => receita_params}) do
    case Receitas.create_receita(receita_params) do
      {:ok, receita} ->
        conn
        |> put_flash(:info, "Receita created successfully.")
        |> redirect(to: ~p"/receitas/#{receita}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    receita = Receitas.get_receita!(id)
    render(conn, :show, receita: receita)
  end

  def edit(conn, %{"id" => id}) do
    receita = Receitas.get_receita!(id)
    changeset = Receitas.change_receita(receita)
    render(conn, :edit, receita: receita, changeset: changeset)
  end

  def update(conn, %{"id" => id, "receita" => receita_params}) do
    receita = Receitas.get_receita!(id)

    case Receitas.update_receita(receita, receita_params) do
      {:ok, receita} ->
        conn
        |> put_flash(:info, "Receita updated successfully.")
        |> redirect(to: ~p"/receitas/#{receita}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, receita: receita, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    receita = Receitas.get_receita!(id)
    {:ok, _receita} = Receitas.delete_receita(receita)

    conn
    |> put_flash(:info, "Receita deleted successfully.")
    |> redirect(to: ~p"/receitas")
  end

  def index(conn, %{"type" => "maiores"}) do
    receita = Receitas.list_maior(:desc)
    render(conn, :index, receitas: receita)
  end

  def index(conn, %{"type" => "menores"}) do
    receita = Receitas.list_menor(:asc)
    render(conn, :index, receitas: receita)
  end

  def index(conn, %{"month" => month}) when month != "" do
    month_number = String.to_integer(month)
    receita = Receitas.list_mes(month_number)
    render(conn, :index, receitas: receita)
  end

  def index(conn, %{"start_date" => start_date, "end_date" => end_date}) do
    receita = Receitas.list_period(start_date, end_date)
    render(conn, :index, receitas: receita)
  end

  def index(conn, _params) do
    receita = Receitas.list_receitas()
    render(conn, :index, receitas: receita)
  end
end
