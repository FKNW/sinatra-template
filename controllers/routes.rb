
class App < Sinatra::Base
  get '/' do
    @title = Conf['title']
    @logs = Log.fetch(10, 0)
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
end
