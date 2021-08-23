import Config
import Dotenvy

source!(".env")

# Cloudinary config
config :cloudex,
  api_key: env!("CLOUDINARY_API_KEY", :string!),
  secret: env!("CLOUDINARY_API_SECRET", :string!),
  cloud_name: env!("CLOUDINARY_CLOUD_NAME", :string!)