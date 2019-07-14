class Application
  @@items = [Item.new("Apples", 5.23), Item.new("Oranges", 2.43)]

  def call(env) # standard
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #setting path 
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if item = @@items.find { |i| i.name == item_name } #find the first item in the items array
        resp.write item.price #print price
      else
        resp.status = 400 # error status
        resp.write "Item not found" #print error statust
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish #finished ?
  end
end
