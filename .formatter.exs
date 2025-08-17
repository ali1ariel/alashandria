# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  plugins: [Spark.Formatter],
  import_deps: [:ash, :reactor, :ash_graphql],
  locals_without_parens: [
    list: :*,
    get: :*,
    create: :*,
    attribute: :*,
    validate: :*
  ]
]
