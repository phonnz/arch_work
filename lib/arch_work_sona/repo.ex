defmodule ArchWorkSona.Repo do
  use Ecto.Repo,
    otp_app: :arch_work_sona,
    adapter: Ecto.Adapters.Postgres
end
