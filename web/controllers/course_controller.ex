defmodule Whitepages2.CourseController do
  use Whitepages2.Web, :controller

  alias Whitepages2.Course

  def index(conn, %{"organization_id" => organization_id}) do
    courses = Apartmentex.all(Repo, Course, organization_id)
    render(conn, "index.html", courses: courses, organization_id: organization_id)
  end

  def new(conn, %{"organization_id" => organization_id}) do
    changeset = Course.changeset(%Course{})
    render(conn, "new.html", changeset: changeset, organization_id: organization_id)
  end

  def create(conn, %{"course" => course_params, "organization_id" => organization_id}) do
    changeset = Course.changeset(%Course{}, course_params)

    case Apartmentex.insert(Repo, changeset, organization_id) do
      {:ok, _course} ->
        conn
        |> put_flash(:info, "Course created successfully.")
        |> redirect(to: organization_course_path(conn, :index, organization_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, organization_id: organization_id)
    end
  end

  def show(conn, %{"id" => id, "organization_id" => organization_id}) do
    course = Apartmentex.get!(Repo, Course, id, organization_id)
    render(conn, "show.html", course: course, organization_id: organization_id)
  end

  def edit(conn, %{"id" => id, "organization_id" => organization_id}) do
    course = Apartmentex.get!(Repo, Course, id, organization_id)
    changeset = Course.changeset(course)
    render(conn, "edit.html", course: course, changeset: changeset)
  end

  def update(conn, %{"id" => id, "course" => course_params, "organization_id" => organization_id}) do
    course = Apartmentex.get!(Repo, Course, id, organization_id)
    changeset = Course.changeset(course, course_params)

    case Repo.update(changeset) do
      {:ok, course} ->
        conn
        |> put_flash(:info, "Course updated successfully.")
        |> redirect(to: organization_course_path(conn, :show, organization_id, course))
      {:error, changeset} ->
        render(conn, "edit.html", course: course, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "organization_id" => organization_id}) do
    course = Apartmentex.get!(Repo, Course, id, organization_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(course)

    conn
    |> put_flash(:info, "Course deleted successfully.")
    |> redirect(to: organization_course_path(conn, :index, organization_id))
  end
end
