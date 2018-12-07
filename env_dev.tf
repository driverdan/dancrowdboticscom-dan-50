
resource "heroku_app" "dev" {
  name   = "${var.app_name}-dev"
  region = "us"

  buildpacks = [
    "heroku/python"
  ]

  config_vars = {
    DEBUG_COLLECTSTATIC = "1"
  }
}

resource "heroku_addon" "database_dev" {
  app  = "${heroku_app.dev.id}"
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "sendgrid_dev" {
  app  = "${heroku_app.dev.id}"
  plan = "sendgrid:starter"
}

resource "heroku_pipeline_coupling" "dev" {
  app      = "${heroku_app.dev.name}"
  pipeline = "${heroku_pipeline.pipeline.id}"
  stage    = "staging"
}
