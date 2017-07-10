defmodule Whitepages2.OrganizationTest do
  use Whitepages2.ModelCase

  alias Whitepages2.Organization

  @valid_attrs %{key: "some content", name: "some content", secret: "some content", settings: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Organization.changeset(%Organization{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Organization.changeset(%Organization{}, @invalid_attrs)
    refute changeset.valid?
  end
end
