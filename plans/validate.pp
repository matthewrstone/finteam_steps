# @summary Finance app post-patch validation: run the smoke test suite.
#
# The finance team's own validation gate for a PSM patch workflow. Runs the app
# smoke test on each target and fails the plan if any node's suite fails, so the
# rolling rollout halts before the next ring is patched.
#
# @param targets Nodes to validate.
# @param endpoint Base URL of the app to test.
# @param suite Named smoke-test suite to run.
plan finteam_steps::validate(
  TargetSpec        $targets,
  Optional[String]  $endpoint = undef,
  String            $suite    = 'core',
) {
  $r = run_task('finteam_steps::smoke_test', $targets,
    endpoint => $endpoint, suite => $suite, _catch_errors => true)

  if $r.error_set.count > 0 {
    out::message("smoke test failed on: ${$r.error_set.names.join(', ')}")
    fail_plan("finteam_steps::validate failed on ${$r.error_set.count} node(s)")
  }

  return({ 'status' => 'validated', 'passed' => $r.ok_set.names })
}
