base_dir = input("base_dir", value: "include")
plan_dirs = input("plan_dirs")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "core/linux-headers")
plan_ident = "#{plan_origin}/#{plan_name}"

hab_pkg_path = command("hab pkg path #{plan_ident}")
describe hab_pkg_path do
  its('exit_status') { should eq 0 }
  its('stdout') { should_not be_empty }
end

target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

plan_dirs.each do | plan_dir |
  describe command("ls -al #{File.join(target_dir, plan_dir)}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
