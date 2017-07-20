defmodule Whitepages2.SectionController do
  use Whitepages2.Web, :controller

  alias Whitepages2.Section

  def index(conn, %{"organization_id" => organization_id}) do
    sections = Repo.all(Section)
    render(conn, "index.json", sections: sections, organization_id: organization_id)
  end

  def create(conn, %{"section" => section_params, "organization_id" => organization_id}) do
    changeset = Section.changeset(%Section{}, section_params)

    case Apartmentex.insert(Repo, changeset, organization_id) do
      {:ok, section} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_section_path(conn, :show, section, organization_id))
        |> render("show.json", section: section, organization_id: organization_id)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset, organization_id: organization_id)
    end
  end

  def show(conn, %{"id" => id, "organization_id" => organization_id}) do
    section = Apartmentex.get!(Repo, Section, id, organization_id)
    render(conn, "show.json", section: section, organization_id: organization_id)
  end

  def update(conn, %{"id" => id, "organization_id" => organization_id, "section" => section_params}) do
    section = Apartmentex.get!(Repo, Section, id, organization_id)
    changeset = Section.changeset(section, section_params)

    case Repo.update(changeset) do
      {:ok, section} ->
        render(conn, "show.json", section: section)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset, organization_id: organization_id)
    end
  end

  def delete(conn, %{"id" => id, "organization_id" => organization_id}) do
    section = Apartmentex.get!(Repo, Section, id, organization_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(section)

    send_resp(conn, :no_content, "")
  end
end
