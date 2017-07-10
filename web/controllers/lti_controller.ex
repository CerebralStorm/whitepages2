require IEx

defmodule Whitepages2.LtiController do
  use Whitepages2.Web, :controller

  alias Whitepages2.Organization
  alias Whitepages2.Course

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

    query = from c in Whitepages2.Course, where: c.canvas_course_id == ^canvas_course_id
    course = Apartmentex.one(Repo, query, organization.id)
    conn |> redirect(to: organization_course_path(conn, :show, course, organization.id))
  end

  def config(conn, _params) do
    render(conn, "config.xml")
  end
end