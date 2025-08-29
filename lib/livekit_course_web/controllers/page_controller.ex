defmodule LivekitCourseWeb.PageController do
  use LivekitCourseWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
