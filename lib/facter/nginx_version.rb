# frozen_string_literal: true
Facter.add('nginx_version') do
    setcode do
      case Facter.value(:kernel)
      when 'windows'
        version_string = Facter::Core::Execution.execute('choco info nginx -r')
          # -r to limit output
        version_string.split('|').last
          # grab everything afer the last '|'
      else
        version_string = Facter::Core::Execution.execute('nginx -v 2>&1')
          # redirect to stdout & stderr
        %r{nginx version: (nginx|openresty)\/([\w\.]+)}.match(version_string)[2]
          # strip the version from the string
      end
    end
  end