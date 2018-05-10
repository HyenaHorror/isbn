require "aws-sdk"

load './local_env.rb' if File.exist?('./local_env.rb')

def check_if_file_exists(filename)
  s3 = Aws::S3::Resource.new(
    region: ENV['AWS_REGION'],
    secret_access_key: ENV['S3_SECRET'],
    access_key_id: ENV['S3_KEY'])
  bucket =  s3.bucket('rb-isbn')

  file = File.basename(filename)

  if bucket.object(file).exists?
    puts "File '/rb-isbn/#{file}' is present in S3 bucket!"
    return true
  else
    puts "File '/rb-isbn/#{file}' is not in S3 bucket!"
    return false
  end
end
