defmodule LiveWebWeb.ErrorJSONTest do
  use LiveWebWeb.ConnCase, async: true

  test "renders 404" do
    assert LiveWebWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert LiveWebWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
