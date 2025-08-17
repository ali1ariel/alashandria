import Config
config :ash, policies: [show_policy_breakdowns?: true]
config :ash, :disable_async?, true
config :ash, :missed_notifications, :ignore
