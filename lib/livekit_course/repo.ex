defmodule LivekitCourse.Repo do
  use Ecto.Repo,
    otp_app: :livekit_course,
    adapter: Ecto.Adapters.Postgres
end
