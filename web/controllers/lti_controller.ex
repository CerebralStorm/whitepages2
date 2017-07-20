require IEx

defmodule Whitepages2.LtiController do
  use Whitepages2.Web, :controller

  alias Whitepages2.Organization
  alias Whitepages2.Course

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def account(conn, %{"oauth_consumer_key" => oauth_consumer_key} = params) do
    organization = Organization
      |> Organization.by_key(oauth_consumer_key)
      |> Whitepages2.Repo.one
    if organization == nil, do: conn |> redirect(to: organization_path(conn, :index))
    render(conn, "index.html", organization_id: organization.id)
  end

  def course(conn, %{"oauth_consumer_key" => oauth_consumer_key} = params) do
    canvas_course_id = params["custom_canvas_course_id"]
    organization = Organization
      |> Organization.by_key(oauth_consumer_key)
      |> Whitepages2.Repo.one
    organization_id = organization.id
    query = from c in Whitepages2.Course, where: c.canvas_course_id == ^canvas_course_id
    course = Apartmentex.one(Repo, query, organization_id)
    if course do
      conn |> redirect(to: organization_course_path(conn, :show, organization_id, course))
    else
      changeset = Course.changeset(%Course{}, %{canvas_course_id: canvas_course_id})
      case Apartmentex.insert(Repo, changeset, organization_id) do
        {:ok, course} ->
          conn
          |> put_flash(:info, "Course created successfully.")
          |> redirect(to: organization_course_path(conn, :show, course, organization_id))
        {:error, _changeset} ->
          render(conn, "index.html", organization_id: organization.id)
      end
    end
  end

  def config(conn, _params) do
    render(conn, "config.xml")
  end
end
