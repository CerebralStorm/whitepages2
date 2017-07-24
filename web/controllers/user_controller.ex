defmodule Whitepages2.UserController do
  use Whitepages2.Web, :controller

  alias Whitepages2.User

  def index(conn, %{"organization_id" => organization_id}) do
    users = Apartmentex.all(Repo, User, organization_id)
    render(conn, "index.json", users: users, organization_id: organization_id)
  end

  def new(conn, %{"organization_id" => organization_id}) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset, organization_id: organization_id)
  end

  def create(conn, %{"user" => user_params, "organization_id" => organization_id}) do
    changeset = User.changeset(%User{}, user_params)

    case Apartmentex.insert(Repo, changeset, organization_id) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_user_path(conn, :show, organization_id, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "organization_id" => organization_id}) do
    user = Apartmentex.get!(Repo, User, id, organization_id)
    render(conn, "show.json", user: user, organization_id: organization_id)
  end

  def edit(conn, %{"id" => id, "organization_id" => organization_id}) do
    user = Apartmentex.get!(Repo, User, id, organization_id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset, organization_id: organization_id)
  end

  def update(conn, %{"id" => id, "user" => user_params, "organization_id" => organization_id}) do
    user = Apartmentex.get!(Repo, User, id, organization_id)
    changeset = User.changeset(user, user_params)

    case Apartmentex.update(Repo, changeset, organization_id) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset, organization_id: organization_id)
    end
  end

  def delete(conn, %{"id" => id, "organization_id" => organization_id}) do
    user = Apartmentex.get!(Repo, User, id, organization_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Apartmentex.delete!(Repo, user, organization_id)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: organization_user_path(conn, :index, organization_id))
  end
end
