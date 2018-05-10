require "aws-sdk"
require "csv"
require_relative "isbn.rb"

load './local_env.rb' if File.exist?('./local_env.rb')
#TODO: Remove excess credential code
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

def upload_new_file_to_bucket(file)
  # Double colon :: accesses items inside of classes/modules
  # In this case we access S3 of Aws, then Client of S3
  client = Aws::S3::Client.new(
    access_key_id: ENV['S3_KEY'],
    secret_access_key: ENV['S3_SECRET'],
    region: ENV['AWS_REGION'])

  bucket = 'rb-isbn'

  #Grabs the filename, stripping any extra dir text.
  name = File.basename(file)

  s3 = Aws::S3::Resource.new(client: client)
  #Creates the object for upload.
  obj = s3.bucket(bucket).object(name)
  obj.upload_file(file)
end

def read_bucket_file(file) #Only working for text files, not CSV
  client = Aws::S3::Client.new(
    access_key_id: ENV['S3_KEY'],
    secret_access_key: ENV['S3_SECRET'],
    region: ENV['AWS_REGION'])
  bucket = 'rb-isbn'
  #Grabs the file, stripping any extra dir text.
  s3 = Aws::S3::Resource.new(client: client)

  obj = s3.bucket(bucket).object(file)
  #Opens file and reads from beginning
  # r is read only
  # b is binary file mode (suppresses CRLF conversion on Windows)
  File.open(file, "rb") do |row|
    return obj.get.body.string
  end

end
