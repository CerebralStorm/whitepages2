require IEx

defmodule Whitepages2.LtiController do
  use Whitepages2.Web, :controller

  alias Whitepages2.Organization

  def account(conn, %{"oauth_consumer_key" => oauth_consumer_key} = params) do
    organization = Organization
      |> Organization.by_key(oauth_consumer_key)
      |> Whitepages2.Repo.one
    if organization == nil, do: conn |> redirect(to: organization_path(conn, :index))
    render(conn, "index.html", organization_id: organization.id)
  end

  def course(conn, %{"oauth_consumer_key" => oauth_consumer_key} = params) do
    organization = Organization
      |> Organization.by_key(oauth_consumer_key)
      |> Whitepages2.Repo.one
    conn |> redirect(to: organization_course_path(conn, :index, organization.id))
  end

  def config(conn, _params) do
    render(conn, "config.xml")
  end
end
