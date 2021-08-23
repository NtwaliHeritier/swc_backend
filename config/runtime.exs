import Config
import Dotenvy

source!(".env")

# Configure your database
config :swc_backend, SwcBackend.Repo,
  username: env!("POSTGRES_USERNAME", :string!),
  password: env!("POSTGRES_PASSWORD", :string!),
  database: env!("POSTGRES_DB", :string!),
  hostname: env!("POSTGRES_HOSTNAME", :string!),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Cloudinary config
config :cloudex,
  api_key: env!("CLOUDINARY_API_KEY", :string!),
  secret: env!("CLOUDINARY_API_SECRET", :string!),
  cloud_name: env!("CLOUDINARY_CLOUD_NAME", :string!)