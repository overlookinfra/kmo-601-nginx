# This is the structure of a simple plan. To learn more about writing
# Puppet plans, see the documentation: http://pup.pt/bolt-puppet-plans
# The summary sets the description of the plan that will appear
# in 'bolt plan show' output. Bolt uses puppet-strings to parse the
# summary and parameters from the plan.
# @summary A plan created with bolt plan new.
# @param targets The targets to run on.
plan nginx::backup_all_logs (
  TargetSpec $targets
) {
  run_plan(facts, targets=>$targets)
  get_targets($targets).each |Target $targ| {
    case $targ.facts['os']['name'] {
      'windows': {
          $source_dir ='C:\tools\nginx-1.23.0\logs'
          $target_dir = 'C:\backups'
        }
      default: {
        $source_dir = '/var/log/nginx'
        $target_dir = '/var/backup'
      }
    }
    run_task(nginx::backup_logs, $targ, {source_dir => $source_dir,target_dir => $target_dir})
  }
}
