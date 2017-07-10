defmodule Whitepages2.EnrollmentController do
  use Whitepages2.Web, :controller

  alias Whitepages2.Enrollment

  def index(conn, %{"organization_id" => organization_id}) do
    enrollments = Repo.all(Enrollment)
    render(conn, "index.json", enrollments: enrollments, organization_id: organization_id)
  end

  def create(conn, %{"enrollment" => enrollment_params, "organization_id" => organization_id}) do
    changeset = Enrollment.changeset(%Enrollment{}, enrollment_params)

    case Repo.insert(changeset) do
      {:ok, enrollment} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_enrollment_path(conn, :show, enrollment, organization_id))
        |> render("show.json", enrollment: enrollment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset, organization_id: organization_id)
    end
  end

  def show(conn, %{"id" => id, "organization_id" => organization_id}) do
    enrollment = Repo.get!(Enrollment, id)
    render(conn, "show.json", enrollment: enrollment, organization_id: organization_id)
  end

  def update(conn, %{"id" => id, "organization_id" => organization_id, "enrollment" => enrollment_params}) do
    enrollment = Repo.get!(Enrollment, id)
    changeset = Enrollment.changeset(enrollment, enrollment_params)

    case Repo.update(changeset) do
      {:ok, enrollment} ->
        render(conn, "show.json", enrollment: enrollment, organization_id: organization_id)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "organization_id" => organization_id}) do
    enrollment = Repo.get!(Enrollment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(enrollment)

    send_resp(conn, :no_content, "")
  end
end
