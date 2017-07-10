defmodule Whitepages2.UserTest do
  use Whitepages2.ModelCase

  alias Whitepages2.User

  @valid_attrs %{canvas_user_id: "some content", data: "some content", sis_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
