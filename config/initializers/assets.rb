# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(admins.css)
Rails.application.config.assets.precompile += %w(index.css)
Rails.application.config.assets.precompile += %w(brands.css)
Rails.application.config.assets.precompile += %w(p.css)
Rails.application.config.assets.precompile += %w(or.css)
Rails.application.config.assets.precompile += %w(odetail.css)
Rails.application.config.assets.precompile += %w(cart.css)
Rails.application.config.assets.precompile += %w(check1.css)
Rails.application.config.assets.precompile += %w(wish.css)
Rails.application.config.assets.precompile += %w(font-awesome.min.css)
Rails.application.config.assets.precompile += %w(jquery.js)
Rails.application.config.assets.precompile += %w(code.js)
