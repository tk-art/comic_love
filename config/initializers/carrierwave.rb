unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['S3_REGION']
    }

    config.storage :fog
    config.fog_public = false
    config.fog_directory  = 'comicshare'
    config.asset_host = 'https://comicshare.s3.amazonaws.com'
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end
end