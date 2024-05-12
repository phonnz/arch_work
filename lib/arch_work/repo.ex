defmodule ArchWork.Repo do
  use Ecto.Repo,
    otp_app: :arch_work,
    adapter: Ecto.Adapters.Postgres
end
