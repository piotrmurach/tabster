# Use this hook to specify the routes for all your tabs
Tabster.configure do |config|
  # Configure the name used to identify tabs in your markup.
  # This can be overwritten when invoking #tabs_for method 
  # in your views.
  config.name = :admin

  # Configure routes used for tab generation. Each tab entry
  # should invoke #add method and pass following parameters
  # :name and [:path_to].
  # All paths are loaded in the order of their declartion.
  config.draw do |map|
    # map.add :dashboard,  :path_to => '/admin/dashboard'

    # If you want to add second level of tab navigation add
    # extra block after the #add method call.

    # map.add :posts, :path_to => '/admin/blog/posts' do |nested|
    #   nested.add :notes, :path_to => '/admin/blog/bla'
    # end
  end
end
