# Defining a Cache with a partitioned topology
defmodule PocMonday.LocalCache do
  use Nebulex.Cache,
    otp_app: :poc_monday,
    adapter: Nebulex.Adapters.Local
end
