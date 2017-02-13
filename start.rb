require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require './model/comment.rb'

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

get '/materialize.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss :materialize
end


get '/' do
  @comments = Comments.order_by(Sequel.desc(:posted_date))
  haml :index
end

put '/comment' do
  Comments.create({
    :name => request[:name],
    :title => request[:title],
    :message => request[:message],
    :posted_date => Time.now,
  })
  redirect '/'
end
