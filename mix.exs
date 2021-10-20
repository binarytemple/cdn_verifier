defmodule CdnVerifier.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cdn_verifier,
      version: "0.1.0",
      elixir: "~> 1.12.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      releases: releases()
    ]
  end

  defp releases do
    [
      cdn_verifier: [
        include_executables_for: [:unix],
        reboot_system_after_config: false,
        strip_beams: [keep: ["Docs", "Dbgi"]],
        applications: [
          runtime_tools: :permanent,
          cdn_verifier: :permanent,
          ace: :permanent
        ]
      ]
    ]
  end

  def application do
    [extra_applications: [:logger], mod: {CdnVerifier.Application, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "verification"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ace, "~> 0.18.6"},
      {:raxx_logger, "~> 0.2.2"},
      {:jason, "~> 1.0"},
      {:exsync, "~> 0.2.3", only: :dev},
      {:httpoison, "~> 1.8.0"},
      {:poison, "~> 4.0.1"},
      {:neuron, "~> 5.0.0"},
      {:morphix, "~> 0.8.1"},
      {:nebulex, "~> 2.1"},
      {:decorator, "~> 1.3"},
      {:telemetry, "~> 0.4"}
    ]
  end

  defp aliases() do
    []
  end
end
