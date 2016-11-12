require 'socket'
require 'timeout'

class PortCheck
  # http://stackoverflow.com/questions/517219/ruby-see-if-a-port-is-open
  def self.udp_open?( ip, port )
    begin
      Timeout::timeout(3) do
        begin
          s = UDPSocket.new
          s.connect(ip, port)
          s.write ("SDFSDSDFSDF\n")
          s.read(1)
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Timeout::Error
          return false
        end
      end
    rescue Timeout::Error
    end

    return false
  end


end
