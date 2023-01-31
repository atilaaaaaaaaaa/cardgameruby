require 'socket'


class Multiplayer
  attr_accessor :server, :client

  def initialize(hostname, port)
    @hostname = hostname
    @port = port
    @client = nil
  end

  def start_server
    @server = TCPServer.open(@port)
  end

  def accept
    @client = @server.accept
  end

  def connect
    @server = TCPSocket.open(@hostname, @port)
  end

  def client_send_obj(msg)
    dumped_msg = Marshal.dump(msg)
    @server.puts(dumped_msg)
  end

  def client_get_obj
    msg = @server.recv(5000)
    Marshal.load(msg)
  end

  def server_send_obj(msg)
    dumped_msg = Marshal.dump(msg)
    @client.puts(dumped_msg)
  end

  def server_get_obj
    msg = @client.recv(5000)
    Marshal.load(msg)
  end

end
