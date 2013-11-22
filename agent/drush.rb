module MCollective
  module Agent
    class Drush<RPC::Agent
      action "cache-clear" do
        reply[:command] = Drush.get_drush_command("cache-clear #{request[:type]}", request)
        reply[:exitcode] = run(reply[:command], :stdout => :stdout, :stderr => :stderr)
        if reply[:exitcode] == 0 then
          reply.statusmsg = "OK"
        else
          reply.fail "FAIL"
        end
      end
      action "updatedb" do
        reply[:command] = Drush.get_drush_command("updatedb", request)
        reply[:exitcode] = run(reply[:command], :stdout => :stdout, :stderr => :stderr)
        if reply[:exitcode] == 0 then
          reply.statusmsg = "OK"
        else
          reply.fail "FAIL"
        end
      end
      def self.get_drush_command(drush_command, request)
        command = request[:drush_path]
        if request[:yes] then
          command += " --yes"
        end
        if request[:no] then
          command += " --yes"
        end
        if request[:uri] then
          command += " --uri=#{request[:uri]}" 
        end
        command += " --root=#{request[:root]}"
        command += " #{drush_command}"

        return command
      end
    end
  end
end
