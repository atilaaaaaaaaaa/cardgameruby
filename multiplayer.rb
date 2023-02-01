require 'socket'


class Multiplayer
  attr_accessor :server, :client

  def initialize(hostname, port)
    @hostname = hostname
    @port = port
    @client = nil
    @s = nil
  end

  def start_server
    @server = TCPServer.open(@port)
  end

  def accept
    @client = @server.accept
  end

  def connect
    @s = TCPSocket.open(@hostname, @port)
  end

  def client_send_obj(msg)
    dumped_msg = Marshal.dump(msg)
    @s.puts(dumped_msg)
  end

  def client_get_obj
    # binding.break
    msg = @s.recv(5000)
    Marshal.load(msg)
  end

  def server_send_obj(msg)
    dumped_msg = Marshal.dump(msg)
    # binding.break
    @client.puts(dumped_msg)
  end

  def server_get_obj
    msg = @client.recv(5000)
    Marshal.load(msg)
  end

  def send_msg(msg)
    server_send_obj(msg) if @s.nil?
    client_send_obj(msg) unless @s.nil?
  end

  def get_msg
    result = server_get_obj if @s.nil?
    result = client_get_obj unless @s.nil?
    result
  end

end
