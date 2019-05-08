workflow "CI" {
  resolves = ["Format", "Lint", "Typecheck", "Test", "Build"]
  on = "push"
}

action "Lint" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = ".build/run"
  args = "eslint"
}

action "Format" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = ".build/run"
  args = "prettier --check '**'"
}

action "Typecheck" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = ".build/run"
  args = "typescript"
}

action "Test" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = ".build/run"
  args = "jest"
}

action "Build" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = ".build/run"
  args = "parcel"
}
