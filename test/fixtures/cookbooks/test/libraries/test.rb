require 'socket'

class Chef
  class Resource
    class RubyBlock
      def wait_for_nomad_port(ip = '127.0.0.1', port = 4646, timeout = 1)
        sleep 1 until nomad_port_is_open?(ip, port, timeout)
      end

      def nomad_port_is_open?(ip = '127.0.0.1', port = 4646, timeout = 1)
        Socket.tcp(ip, port, connect_timeout: timeout)
        true
      rescue Errno::ETIMEDOUT, Errno::ECONNREFUSED
        false
      end
    end
  end
end
