module MCollective
  module Agent
    class Drush<RPC::Agent
      action "cache-clear" do
        reply[:exitcode], reply[:stdout], reply[:stderr], reply[:command] = Drush.run("cache clear #{request[type]}", request)
        if reply[:exitcode] == 0 then
          reply.statusmsg = "OK"
        else
          reply.fail "FAIL"
        end
      end
      action "updatedb" do
        reply[:exitcode], reply[:stdout], reply[:stderr], reply[:command] = Drush.run("updatedb", request)
        if reply[:exitcode] == 0 then
          reply.statusmsg = "OK"
        else
          reply.fail "FAIL"
        end
      end
      def self.run(drush_command, request)
        command = "/usr/bin/drush"
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

        output = ""
        output_errors = ""
        shell = Shell.new(command, {:stdout => output, :stderr => output_errors, :chomp => true})
        shell.runcommand
        exitcode = shell.status.exitstatus

        return exitcode, output, output_errors, command
      end
    end
  end
end
