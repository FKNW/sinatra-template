gem install bundler foreman
bundle install --path vendor/bundle
if [ ! -e config.yml ]; then
cp sample.config.yml config.yml
fi
