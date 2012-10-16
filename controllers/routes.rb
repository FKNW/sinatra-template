
class App < Sinatra::Base
  get '/' do
    @title = Conf['title']
    @logs = Log.fetch(10, 0)
    @files = UploadFile.fetch(10, 0)
    haml :index
  end

  get '/omikuji.json' do
    name = params[:name]
    lucky = Conf['omikuji'].sample
    log = nil
    DB.transaction do
      user = User.find_or_create(:name => @name)
      log = Log.create(:user_id => user.id, :lucky => lucky)
    end

    @mes = {
      :result => lucky,
      :time => log.created_at,
      :name => name
    }.to_json
  end

  get '/upload' do
    content_type 'text/html'
    haml :upload
  end

  post '/upload' do
    if params[:myfile] then
      new_filename = DateTime.now.strftime('%s') + File.extname(params[:myfile][:filename])
      Dir::mkdir('./public/files/') if not File.exists?('./public/files/')
      save_file = './public/files/' + new_filename
      File.open(save_file, 'wb') { |f| f.write(params[:myfile][:tempfile].read) }

      upload_file = UploadFile.create(:filename => new_filename)

      content_type 'text/plain'
      'upload completed!'
    else
      content_type 'text/plain'
      'POST with "file" arg.'
    end
  end
end
